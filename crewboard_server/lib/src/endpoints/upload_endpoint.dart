import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:serverpod/serverpod.dart';
import 'package:path/path.dart' as p;

class UploadEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String?> uploadFile(
    Session session,
    String path,
    ByteData data,
  ) async {
    try {
      // 1. Validate file extension (basic security)
      final ext = p.extension(path).toLowerCase();
      final allowedExtensions = {
        '.jpg',
        '.jpeg',
        '.png',
        '.gif',
        '.webp',
        '.mp4',
        '.mov',
        '.pdf'
      };
      if (!allowedExtensions.contains(ext)) {
        throw Exception('File type not allowed: $ext');
      }

      // 2. Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final random = Random().nextInt(10000);
      final filename = '${timestamp}_$random$ext';

      // 3. Define storage path (web/public/uploads)
      final publicUrl = 'http://localhost:8082/uploads/$filename';
      // Adjust if running in production or different config
      // Ideally read from config, but for now hardcode or infer

      // Ensure directory exists
      final uploadDir = Directory(p.join(Directory.current.path, 'web', 'public', 'uploads'));
      if (!await uploadDir.exists()) {
        await uploadDir.create(recursive: true);
      }

      final file = File(p.join(uploadDir.path, filename));

      // 4. Write data
      await file.writeAsBytes(data.buffer.asUint8List());

      return publicUrl;
    } catch (e, stack) {
      session.log('Upload failed: $e', level: LogLevel.error, exception: e, stackTrace: stack);
      return null;
    }
  }
}
