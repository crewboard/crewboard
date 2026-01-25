import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:path_provider/path_provider.dart';
import '../../widgets/image_editor/pro_image_editor.dart';
import '../../controllers/messages_controller.dart';
import '../../config/palette.dart';
import '../../widgets/video_preview.dart';
import '../../widgets/audio_preview.dart';

class FilePreviewOverlay extends StatefulWidget {
  const FilePreviewOverlay({super.key});

  @override
  State<FilePreviewOverlay> createState() => _FilePreviewOverlayState();
}

class _FilePreviewOverlayState extends State<FilePreviewOverlay> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesController = Get.find<MessagesController>();

    return Obx(() {
      if (!messagesController.showFilePreview.value) {
        return const SizedBox.shrink();
      }

      final files = messagesController.attachedFiles;

      if (files.isEmpty) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.file_copy_outlined, color: Pallet.font3),
                const SizedBox(width: 12),
                Text(
                  "Preview Files (${files.length})",
                  style: TextStyle(
                    color: Pallet.font3,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: messagesController.closeFilePreview,
                  child: Icon(Icons.close, color: Pallet.font3),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: files.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final file = files[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: _FilePreviewItem(
                        file: file,
                        onRemove: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
            if (files.length > 1) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 60,
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: files.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final file = files[index];
                      final isSelected = index == _currentIndex;
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(color: Colors.blue, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: _ThumbnailItem(file: file),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}

class _ThumbnailItem extends StatelessWidget {
  final File file;

  const _ThumbnailItem({required this.file});

  @override
  Widget build(BuildContext context) {
    final messagesController = Get.find<MessagesController>();
    final type = messagesController.getMessageTypeFromFile(file);

    if (type == MessageType.image) {
      return Image.file(
        file,
        fit: BoxFit.cover,
      );
    } else if (type == MessageType.video) {
      return Container(
        color: Colors.black26,
        child: const Center(
          child: Icon(Icons.play_arrow, color: Colors.white, size: 20),
        ),
      );
    } else {
      return Container(
        color: Colors.black26,
        child: const Center(
          child: Icon(Icons.insert_drive_file, color: Colors.white, size: 20),
        ),
      );
    }
  }
}

class _FilePreviewItem extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const _FilePreviewItem({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final messagesController = Get.find<MessagesController>();
    final type = messagesController.getMessageTypeFromFile(file);

    if (type != MessageType.image) {
      Widget content;
      if (type == MessageType.video) {
        content = Center(
          child: VideoPreview(file: file),
        );
      } else if (type == MessageType.audio) {
        content = Center(
          child: AudioPreview(
            url: file.path,
            localUrl: true,
            color: Colors.white, // Or generic preview color
          ),
        );
      } else {
        content = const Center(
          child: Icon(Icons.insert_drive_file, size: 48, color: Colors.white),
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: content,
      );
    }

    // Embedded Editor for Images
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ProImageEditor.file(
        file,
        key: ValueKey(file.path), // Rebuild if file changes (e.g. after edit)
        configs: const ProImageEditorConfigs(
          mainEditor: MainEditorConfigs(
            enableCloseButton: false,
            style: MainEditorStyle(
              bottomBarBackground: Colors.transparent,
              appBarBackground: Colors.transparent,
              background: Colors.transparent,
              outsideCaptureAreaLayerOpacity: 0,
            ),
          ),
        ),
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            try {
              final tempDir = await getTemporaryDirectory();
              final fileName =
                  'edited_${DateTime.now().millisecondsSinceEpoch}.jpg';
              final newFile = File('${tempDir.path}/$fileName');
              await newFile.writeAsBytes(bytes);

              final messagesController = Get.find<MessagesController>();
              final index = messagesController.attachedFiles.indexOf(file);
              if (index != -1) {
                // Determine if we are updating the list or creating a new one to force refresh
                // messagesController.attachedFiles[index] = newFile;
                // Using set range or similar might be safer for Obx
                messagesController.attachedFiles[index] = newFile;
                messagesController.attachedFiles.refresh();
              }
            } catch (e) {
              debugPrint('Error saving edited image: $e');
            }
          },
          onCloseEditor: (_) {
            // Do nothing on close, just stay in preview
          },
        ),
      ),
    );
  }
}
