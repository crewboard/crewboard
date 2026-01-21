import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crewboard_server/src/generated/protocol.dart';

class GiphyEndpoint extends Endpoint {
  Future<String?> getApiKey(Session session) async {
    return session.server.passwords['giphy_api_key'];
  }

  Future<List<Gif>> getGifs(Session session, {String? query, int limit = 20, int offset = 0}) async {
    final apiKey = await getApiKey(session);
    if (apiKey == null || apiKey == 'YOUR_GIPHY_API_KEY_HERE') return [];

    final baseUrl = query == null || query.isEmpty
        ? 'https://api.giphy.com/v1/gifs/trending'
        : 'https://api.giphy.com/v1/gifs/search';

    final url = Uri.parse(baseUrl).replace(queryParameters: {
      'api_key': apiKey,
      if (query != null && query.isNotEmpty) 'q': query,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'rating': 'g',
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List gifsData = data['data'];
        return gifsData.map((g) {
          return Gif(
            id: g['id'],
            url: g['images']['original']['url'],
            title: g['title'],
            previewUrl: g['images']['fixed_height_small']['url'],
          );
        }).toList();
      }
    } catch (e) {
      session.log('Error fetching GIFs: $e');
    }

    return [];
  }
}
