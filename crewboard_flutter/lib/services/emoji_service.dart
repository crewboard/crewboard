import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:crewboard_client/crewboard_client.dart';

class EmojiService {
  static final EmojiService _instance = EmojiService._internal();
  factory EmojiService() => _instance;
  EmojiService._internal();

  Database? _db;
  final _store = intMapStoreFactory.store('emojis');

  Future<void> init() async {
    if (_db != null) return;

    if (kIsWeb) {
      var factory = databaseFactoryWeb;
      _db = await factory.openDatabase('emojis.db');
    } else {
      var dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      var dbPath = join(dir.path, 'emojis.db');
      var factory = databaseFactoryIo;
      _db = await factory.openDatabase(dbPath);
    }
  }

  Future<int> getCount() async {
    await init();
    return await _store.count(_db!);
  }

  Future<void> addEmojis(List<Emoji> emojis) async {
    await init();
    await _db!.transaction((txn) async {
      for (var emoji in emojis) {
        // We use the emoji ID as the key if available, or auto-increment
        // Since we are mirroring the server, assuming server IDs are consistent
        if (emoji.id != null) {
          await _store.record(emoji.id!).put(txn, emoji.toJson());
        } else {
          await _store.add(txn, emoji.toJson());
        }
      }
    });
  }

  Future<List<Emoji>> getAllEmojis() async {
    await init();
    final snapshots = await _store.find(
      _db!,
      finder: Finder(sortOrders: [SortOrder('id')]),
    );
    
    return snapshots.map((snapshot) {
      return Emoji.fromJson(snapshot.value as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Emoji>> searchEmojis(String query) async {
    await init();
    final snapshots = await _store.find(
      _db!,
      finder: Finder(
        filter: Filter.or([
          Filter.custom((record) {
            final emoji = Emoji.fromJson(record.value as Map<String, dynamic>);
            return emoji.annotation.toLowerCase().contains(query.toLowerCase()) ||
                   emoji.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())) ||
                   emoji.shortcodes.any((s) => s.toLowerCase().contains(query.toLowerCase()));
          }),
        ]),
        sortOrders: [SortOrder('id')],
      ),
    );

    return snapshots.map((snapshot) {
      return Emoji.fromJson(snapshot.value as Map<String, dynamic>);
    }).toList();
  }

  Future<List<String>> getGroups() async {
    await init();
    final snapshots = await _store.find(_db!);
    final groups = snapshots
        .map((s) => Emoji.fromJson(s.value as Map<String, dynamic>).group)
        .toSet()
        .toList();
    groups.sort();
    return groups;
  }

  Future<List<Emoji>> getEmojisByGroup(String group) async {
    await init();
    final snapshots = await _store.find(
      _db!,
      finder: Finder(
        filter: Filter.equals('group', group),
        sortOrders: [SortOrder('id')],
      ),
    );

    return snapshots.map((snapshot) {
      return Emoji.fromJson(snapshot.value as Map<String, dynamic>);
    }).toList();
  }
  
  Future<void> clear() async {
    await init();
    await _store.delete(_db!);
  }
}
