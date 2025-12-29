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

    return await ChatRoom.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
      orderBy: (t) => t.roomName,
    );
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
          roomName: otherUser.userName,
          roomType: 'direct',
          messageCount: 0,
        ),
        transaction: transaction,
      );

      // Map both users to the room
      await UserRoomMap.db.insertRow(
        session,
        UserRoomMap(roomId: room.id!, userId: currentUserId),
        transaction: transaction,
      );
      await UserRoomMap.db.insertRow(
        session,
        UserRoomMap(roomId: room.id!, userId: otherUserId),
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
      room.messageCount += 1;
      await ChatRoom.db.updateRow(session, room);
    }

    await session.messages.postMessage(
      'chat_${message.roomId}',
      savedMessage,
    );
  }

  @override
  Future<void> handleStreamMessage(
    StreamingSession session,
    SerializableModel message,
  ) async {
    if (message is ChatRoom) {
      session.messages.addListener('chat_${message.id}', (msg) {
        // ignore: deprecated_member_use
        sendStreamMessage(session, msg);
      });
    }
  }
}
