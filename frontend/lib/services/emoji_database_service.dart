import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/services/arri_client.rpc.dart';

class EmojiDatabaseService {
  static const String _dbName = 'emojis.db';
  static const String _storeName = 'emojis';
  static const String _lastSyncIdKey = 'lastSyncId';

  Database? _database;
  StoreRef<String, Map<String, dynamic>>? _store;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDir.path, _dbName);
    _database = await databaseFactoryIo.openDatabase(dbPath);
    _store = stringMapStoreFactory.store(_storeName);
    return _database!;
  }

  Future<StoreRef<String, Map<String, dynamic>>> get _emojiStore async {
    await _db;
    return _store!;
  }

  // Get the last synced emoji ID
  Future<int?> getLastSyncId() async {
    final store = await _emojiStore;
    final record = await store.record(_lastSyncIdKey).get(_database!);
    return record?['id'] as int?;
  }

  // Set the last synced emoji ID
  Future<void> setLastSyncId(int id) async {
    final store = await _emojiStore;
    await store.record(_lastSyncIdKey).put(_database!, {'id': id});
  }

  // Save emojis to database
  Future<void> saveEmojis(List<Map<String, dynamic>> emojis) async {
    final store = await _emojiStore;
    final db = await _db;

    await db.transaction((txn) async {
      for (final emoji in emojis) {
        final key = emoji['id'].toString();
        await store.record(key).put(txn, emoji);
      }
    });

    // Update last sync ID if we have emojis
    if (emojis.isNotEmpty) {
      final lastId = emojis.last['id'] as int;
      await setLastSyncId(lastId);
    }
  }

  // Get all emojis from database
  Future<List<Map<String, dynamic>>> getAllEmojis() async {
    final store = await _emojiStore;
    final records = await store.find(_database!);
    final emojis = records.map((record) => record.value).toList();
    print('Loaded ${emojis.length} emojis from local database');
    return emojis;
  }

  // Sync emojis from API with pagination
  Future<void> syncEmojis() async {
    try {
      int? lastId = await getLastSyncId();
      bool hasMore = true;
      print('Starting emoji sync. Last sync ID: $lastId');

      while (hasMore) {
        final params = lastId != null ? GetEmojisParams(lastId: lastId.toDouble()) : GetEmojisParams();
        final response = await server.emojis.getEmojis(params);
        print('Fetched emoji batch. Response data length: ${response.data?.length ?? 0}');

        if (response.data != null && response.data!.isNotEmpty) {
          final emojis = response.data!.map((emoji) => {
            'id': emoji.id,
            'group': emoji.group,
            'subGroup': emoji.subGroup,
            'name': emoji.name,
            'code': emoji.code,
            'emoji': emoji.emoji,
            'tags': emoji.tags,
          }).toList();

          await saveEmojis(emojis);
          lastId = emojis.last['id'] as int;
          print('Saved ${emojis.length} emojis. New last ID: $lastId');
        } else {
          hasMore = false;
          print('No more emojis to sync');
        }
      }
      print('Emoji sync completed');
    } catch (e) {
      print('Error syncing emojis: $e');
      rethrow;
    }
  }

  // Close database
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

// Singleton instance
final emojiDatabaseService = EmojiDatabaseService();