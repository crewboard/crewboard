import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ChatEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<ChatRoom>> getRooms(Session session) async {
    // TODO: Resolve auth extension issue in Serverpod 3.1
    // Using placeholder userId 1 for initial development/seeding
    const userId = 1;

    final roomMaps = await UserRoomMap.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final roomIds = roomMaps.map((m) => m.roomId).toSet();
    if (roomIds.isEmpty) return [];

    return await ChatRoom.db.find(
      session,
      where: (t) => t.id.inSet(roomIds),
    );
  }

  Future<List<ChatMessage>> getMessages(
    Session session,
    int roomId, {
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
    const userId = 1; // TODO: Fix

    message.userId = userId;
    message.createdAt = DateTime.now();

    final savedMessage = await ChatMessage.db.insertRow(session, message);

    final room = await ChatRoom.db.findById(session, message.roomId);
    if (room != null) {
      room.lastMessageId = savedMessage.id;
      room.messageCount += 1;
      await ChatRoom.db.updateRow(session, room);
    }

    session.messages.postMessage(
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
        sendStreamMessage(session, msg);
      });
    }
  }
}
