import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/emoji_service.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../main.dart'; // To access serverpod client 'client'

class EmojiState {
  final bool isLoading;
  final double syncProgress;
  final int totalEmojis;
  final int localCount;

  EmojiState({
    this.isLoading = true,
    this.syncProgress = 0.0,
    this.totalEmojis = 0,
    this.localCount = 0,
  });

  EmojiState copyWith({
    bool? isLoading,
    double? syncProgress,
    int? totalEmojis,
    int? localCount,
  }) {
    return EmojiState(
      isLoading: isLoading ?? this.isLoading,
      syncProgress: syncProgress ?? this.syncProgress,
      totalEmojis: totalEmojis ?? this.totalEmojis,
      localCount: localCount ?? this.localCount,
    );
  }
}

final emojiProvider = NotifierProvider<EmojiNotifier, EmojiState>(
  EmojiNotifier.new,
);

class EmojiNotifier extends Notifier<EmojiState> {
  final EmojiService _emojiService = EmojiService();

  @override
  EmojiState build() {
    // Start sync immediately after initialization
    Future.microtask(() => _syncEmojis());
    return EmojiState();
  }

  Future<void> _syncEmojis() async {
    try {
      await _emojiService.init();

      // Get counts
      final localCount = await _emojiService.getCount();
      final totalEmojis = await client.emoji.getEmojiCount();

      print('Emoji Sync: Local=$localCount, Server=$totalEmojis');

      state = state.copyWith(
        localCount: localCount,
        totalEmojis: totalEmojis,
        isLoading: localCount < totalEmojis,
      );

      if (localCount < totalEmojis) {
        await _downloadEmojis(offset: localCount);
      } else {
        print('Emoji Sync: Already up to date.');
      }
    } catch (e) {
      print('Emoji Sync Error: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _downloadEmojis({required int offset}) async {
    const int batchSize = 100;
    int currentOffset = offset;

    while (currentOffset < state.totalEmojis) {
      try {
        print('Fetching emojis from $currentOffset...');
        final emojis = await client.emoji.getEmojis(
          limit: batchSize,
          offset: currentOffset,
        );

        if (emojis.isEmpty) break;

        await _emojiService.addEmojis(emojis);

        currentOffset += emojis.length;
        state = state.copyWith(
          localCount: currentOffset,
          syncProgress: currentOffset / state.totalEmojis,
        );

        // Tiny delay to yield to UI thread
        await Future.delayed(const Duration(milliseconds: 10));
      } catch (e) {
        print('Error downloading batch at $currentOffset: $e');
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
