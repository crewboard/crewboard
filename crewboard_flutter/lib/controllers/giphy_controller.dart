import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../main.dart';

class GiphyController extends GetxController {
  var apiKey = "".obs;
  var trendingGifs = <Gif>[].obs;
  var searchResults = <Gif>[].obs;
  var isLoading = false.obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApiKey();
    fetchTrending();
  }

  Future<void> fetchApiKey() async {
    try {
      final key = await client.giphy.getApiKey();
      if (key != null) {
        apiKey.value = key;
      }
    } catch (e) {
      print("Error fetching Giphy API key: $e");
    }
  }

  Future<void> fetchTrending() async {
    isLoading.value = true;
    try {
      final gifs = await client.giphy.getGifs(limit: 20, offset: 0);
      trendingGifs.value = gifs;
    } catch (e) {
      print("Error fetching trending GIFs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      isSearching.value = false;
      return;
    }
    isSearching.value = true;
    isLoading.value = true;
    try {
      final gifs = await client.giphy.getGifs(
        query: query,
        limit: 20,
        offset: 0,
      );
      searchResults.value = gifs;
    } catch (e) {
      print("Error searching GIFs: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
