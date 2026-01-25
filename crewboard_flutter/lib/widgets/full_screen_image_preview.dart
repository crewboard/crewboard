import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class FullScreenImagePreview extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePreview({super.key, required this.imageUrl});

  @override
  State<FullScreenImagePreview> createState() => _FullScreenImagePreviewState();
}

class _FullScreenImagePreviewState extends State<FullScreenImagePreview> {
  bool isDownloading = false;

  Future<void> _downloadImage() async {
    setState(() {
      isDownloading = true;
    });

    try {
      // 1. Fetch image data
      final ByteData data = await NetworkAssetBundle(
        Uri.parse(widget.imageUrl),
      ).load("");
      final Uint8List bytes = data.buffer.asUint8List();

      // 2. Determine file name
      String fileName = "image.png";
      try {
        final uri = Uri.parse(widget.imageUrl);
        final segments = uri.pathSegments;
        if (segments.isNotEmpty) {
          fileName = segments.last;
        }
      } catch (_) {}

      // Ensure extension
      if (!p.extension(fileName).isNotEmpty) {
        fileName += ".png";
      }

      // 3. User picks location
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Image',
        fileName: fileName,
        type: FileType.image,
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsBytes(bytes);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image saved successfully')),
          );
        }
      }
    } catch (e) {
      debugPrint("Download error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                if (isDownloading)
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _downloadImage,
                    tooltip: 'Download',
                  ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
