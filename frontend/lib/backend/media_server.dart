import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'server.dart';
import '../services/local_storage_service.dart';

class MediaServer {
  /// Uploads media bytes to backend `/media/upload` via multipart/form-data.
  /// Returns the URL string on success, or null on failure.
  static Future<String?> uploadImage({
    required String originalName,
    required Uint8List bytes,
    String? path,
  }) async {
    try {
      print("sanding");
      final uri = Uri.parse('$baseUrl/media/upload');
      final request = http.MultipartRequest('POST', uri);

      final multipart = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: originalName,
      );
      request.files.add(multipart);

      // Determine target directory: prefer explicit path; else use userId
      String? directory = path;
      directory ??= await LocalStorageService.getUserId();
      if (directory != null && directory.isNotEmpty) {
        request.fields['directory'] = directory; // Changed from 'userId' to 'directory'
      }
      print("Sending request to $uri with directory: $directory");

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = response.body;
        final data = convert.jsonDecode(body) as Map<String, dynamic>;
        if (data['success'] == true && data['url'] is String) {
          print("komplethed ${data['url']}");

          return data['url'] as String;
        }
      }
      print("komplethed no datha");
      return null;
    } catch (e) {
      print('Error uploading media to backend: $e');
      return null;
    }
  }
}
