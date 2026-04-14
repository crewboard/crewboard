import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../main.dart';

class GiphyState {
  final String apiKey;
  final List<Gif> trendingGifs;
  final List<Gif> searchResults;
  final bool isLoading;
  final bool isSearching;

  GiphyState({
    this.apiKey = "",
    this.trendingGifs = const [],
    this.searchResults = const [],
    this.isLoading = false,
    this.isSearching = false,
  });

  GiphyState copyWith({
    String? apiKey,
    List<Gif>? trendingGifs,
    List<Gif>? searchResults,
    bool? isLoading,
    bool? isSearching,
  }) {
    return GiphyState(
      apiKey: apiKey ?? this.apiKey,
      trendingGifs: trendingGifs ?? this.trendingGifs,
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

final giphyProvider = NotifierProvider<GiphyNotifier, GiphyState>(GiphyNotifier.new);

class GiphyNotifier extends Notifier<GiphyState> {
  @override
  GiphyState build() {
    _init();
    return GiphyState();
  }

  Future<void> _init() async {
    await fetchApiKey();
    await fetchTrending();
  }

  Future<void> fetchApiKey() async {
    try {
      final key = await client.giphy.getApiKey();
      if (key != null) {
        state = state.copyWith(apiKey: key);
      }
    } catch (e) {
      print("Error fetching Giphy API key: $e");
    }
  }

  Future<void> fetchTrending() async {
    state = state.copyWith(isLoading: true);
    try {
      final gifs = await client.giphy.getGifs(limit: 20, offset: 0);
      state = state.copyWith(trendingGifs: gifs);
    } catch (e) {
      print("Error fetching trending GIFs: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(isSearching: false);
      return;
    }
    state = state.copyWith(isSearching: true, isLoading: true);
    try {
      final gifs = await client.giphy.getGifs(
        query: query,
        limit: 20,
        offset: 0,
      );
      state = state.copyWith(searchResults: gifs);
    } catch (e) {
      print("Error searching GIFs: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
