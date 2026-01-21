import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils.dart';

class ChatEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<ChatRoom>> getRooms(Session session) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final userId = user.id!;

    final roomMaps = await UserRoomMap.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final roomIds = roomMaps.map((m) => m.roomId).toSet();
    if (roomIds.isEmpty) return [];

    final rooms = await ChatRoom.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
      orderBy: (t) => t.roomName,
      include: ChatRoom.include(lastMessage: ChatMessage.include()),
    );

    // Map the per-user unread count first
    for (var room in rooms) {
      final map = roomMaps.firstWhere((m) => m.roomId == room.id);
      room.messageCount = map.unreadCount;
    }

    // Identify Direct Rooms and fetch other participants
    final directRooms = rooms.where((r) => r.roomType == 'direct').toList();
    if (directRooms.isNotEmpty) {
      final directRoomIds = directRooms.map((r) => r.id!).toSet();
      
      // Find UserRoomMaps for these rooms where user is NOT current user
      final otherUserMaps = await UserRoomMap.db.find(
        session,
        where: (t) => t.roomId.inSet(directRoomIds) & t.userId.notEquals(userId),
      );

      final otherUserIds = otherUserMaps.map((m) => m.userId).toSet();
      final otherUsers = await User.db.find(
        session,
        where: (t) => t.id.inSet(otherUserIds),
      );

      for (var room in directRooms) {
        // Find the map for this room
        try {
            final otherMap = otherUserMaps.firstWhere((m) => m.roomId == room.id);
            final otherUser = otherUsers.firstWhere((u) => u.id == otherMap.userId);
            room.roomName = otherUser.userName;
        } catch (e) {
            // If checking against self or user deleted, fallback
            if (room.roomName == null || room.roomName!.contains('-')) {
                 room.roomName = 'Unknown User';
            }
        }
      }
    }

    return rooms;
  }

  Future<List<User>> searchUsers(Session session, String query) async {
    final currentUser = await AuthHelper.getAuthenticatedUser(session);
    if (query.isEmpty) return [];

    return await User.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(currentUser.organizationId) &
          (t.userName.ilike('%$query%') |
              t.firstName.ilike('%$query%') |
              t.lastName.ilike('%$query%')) &
          t.id.notEquals(currentUser.id!),
      limit: 10,
    );
  }

  Future<ChatRoom> createDirectRoom(
    Session session,
    UuidValue otherUserId,
  ) async {
    final currentUser = await AuthHelper.getAuthenticatedUser(session);
    final currentUserId = currentUser.id!;

    // 1. Check if a direct room already exists between these two users
    final myRooms = await UserRoomMap.db.find(
      session,
      where: (t) => t.userId.equals(currentUserId),
    );
    final myRoomIds = myRooms.map((e) => e.roomId).toSet();

    if (myRoomIds.isNotEmpty) {
      final existingMap = await UserRoomMap.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(otherUserId) & t.roomId.inSet(myRoomIds),
      );

      if (existingMap != null) {
        final room = await ChatRoom.db.findById(session, existingMap.roomId);
        if (room != null && room.roomType == 'direct') {
          return room;
        }
      }
    }

    // 2. Create new room if none exists
    final otherUser = await User.db.findById(session, otherUserId);
    if (otherUser == null) throw Exception('User not found');

    return await session.db.transaction((transaction) async {
      final room = await ChatRoom.db.insertRow(
        session,
        ChatRoom(
          roomName: 'Direct Message',
          roomType: 'direct',
          messageCount: 0,
        ),
        transaction: transaction,
      );

      // Map both users to the room
      await UserRoomMap.db.insertRow(
        session,
        UserRoomMap(roomId: room.id!, userId: currentUserId, unreadCount: 0),
        transaction: transaction,
      );
      await UserRoomMap.db.insertRow(
        session,
        UserRoomMap(roomId: room.id!, userId: otherUserId, unreadCount: 0),
        transaction: transaction,
      );

      return room;
    });
  }

  Future<List<ChatMessage>> getMessages(
    Session session,
    UuidValue roomId, {
    int limit = 50,
    int offset = 0,
  }) async {
    return await ChatMessage.db.find(
      session,
      where: (t) => t.roomId.equals(roomId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  Future<void> sendMessage(Session session, ChatMessage message) async {
    final user = await AuthHelper.getAuthenticatedUser(session);

    message.userId = user.id!;
    message.createdAt = DateTime.now();

    final savedMessage = await ChatMessage.db.insertRow(session, message);

    final room = await ChatRoom.db.findById(session, message.roomId);
    if (room != null) {
      room.lastMessageId = savedMessage.id;
      // room.messageCount += 1; // This is now per-user in UserRoomMap
      await ChatRoom.db.updateRow(session, room);
    }

    // Increment unread count for other users in the room
    final otherUserMaps = await UserRoomMap.db.find(
      session,
      where: (t) =>
          t.roomId.equals(message.roomId) & t.userId.notEquals(user.id!),
    );

    for (var userMap in otherUserMaps) {
      userMap.unreadCount += 1;
      await UserRoomMap.db.updateRow(session, userMap);
    }

    await session.messages.postMessage(
      'chat_${message.roomId}',
      ChatStreamEvent(message: savedMessage),
    );
  }

  Stream<ChatStreamEvent> subscribeToRoom(Session session, UuidValue roomId) async* {
    var stream = session.messages.createStream<ChatStreamEvent>('chat_$roomId');
    yield* stream;
  }

  Future<void> sendTyping(
    Session session,
    bool isTyping,
    UuidValue roomId,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final indicator = TypingIndicator(
      userId: user.id!,
      roomId: roomId,
      isTyping: isTyping,
      userName: user.userName,
    );

    await session.messages.postMessage(
      'chat_$roomId',
      ChatStreamEvent(typing: indicator),
    );
  }



  Future<void> markAsRead(Session session, UuidValue roomId) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final userMap = await UserRoomMap.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id!) & t.roomId.equals(roomId),
    );

    if (userMap != null) {
      userMap.unreadCount = 0;
      await UserRoomMap.db.updateRow(session, userMap);
    }
  }
}
