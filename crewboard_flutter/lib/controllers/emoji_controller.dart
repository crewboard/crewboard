import 'package:get/get.dart';
import '../services/emoji_service.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../main.dart'; // To access serverpod client 'client'

class EmojiController extends GetxController {
  final EmojiService _emojiService = EmojiService();

  var isLoading = true.obs;
  var syncProgress = 0.0.obs;
  var totalEmojis = 0.obs;
  var localCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    syncEmojis();
  }

  Future<void> syncEmojis() async {
    try {
      await _emojiService.init();

      // Get counts
      localCount.value = await _emojiService.getCount();
      totalEmojis.value = await client.emoji.getEmojiCount();

      print('Emoji Sync: Local=$localCount, Server=$totalEmojis');

      if (localCount.value < totalEmojis.value) {
        isLoading.value = true;
        await _downloadEmojis(offset: localCount.value);
      } else {
        print('Emoji Sync: Already up to date.');
      }
    } catch (e) {
      print('Emoji Sync Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _downloadEmojis({required int offset}) async {
    const int batchSize = 100;
    int currentOffset = offset;

    while (currentOffset < totalEmojis.value) {
      try {
        print('Fetching emojis from $currentOffset...');
        final emojis = await client.emoji.getEmojis(
          limit: batchSize,
          offset: currentOffset,
        );

        if (emojis.isEmpty) break;

        await _emojiService.addEmojis(emojis);

        currentOffset += emojis.length;
        localCount.value = currentOffset;
        syncProgress.value = currentOffset / totalEmojis.value;

        // Tiny delay to yield to UI thread if needed, though await does that
        await Future.delayed(Duration(milliseconds: 10));
      } catch (e) {
        print('Error downloading batch at $currentOffset: $e');
        // Stop on error, will resume next app start
        break;
      }
    }
    print('Emoji Sync Completed.');
  }

  Future<List<Emoji>> getEmojis() async {
    return await _emojiService.getAllEmojis();
  }

  Future<List<Emoji>> searchEmojis(String query) async {
    return await _emojiService.searchEmojis(query);
  }

  Future<List<String>> getGroups() async {
    return await _emojiService.getGroups();
  }

  Future<List<Emoji>> getEmojisByGroup(String group) async {
    return await _emojiService.getEmojisByGroup(group);
  }
}
