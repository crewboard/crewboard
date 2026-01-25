import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class EmojiEndpoint extends Endpoint {
  Future<int> getEmojiCount(Session session) async {
    return await Emoji.db.count(session);
  }

  Future<List<Emoji>> getEmojis(
    Session session, {
    int? limit,
    int? offset,
  }) async {
    return await Emoji.db.find(
      session,
      limit: limit,
      offset: offset,
      orderBy: (e) => e.id,
    );
  }
}
