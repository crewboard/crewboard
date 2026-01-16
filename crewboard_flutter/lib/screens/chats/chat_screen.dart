import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import 'chat_widgets.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../memory_bank/memory_bank_screen.dart';
import 'ticket_threads_full_view.dart';
import 'file_preview_overlay.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subPage = Window.subPage.value;
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                if (subPage == 'memory')
                  const Expanded(child: MemoryBankScreen())
                else if (subPage == 'planner')
                  const Expanded(child: TicketThreadsFullView())
                else
                  const Expanded(child: Messages()),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
    });
  }
}

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final roomsController = Get.put(RoomsController());
    final messagesController = Get.put(MessagesController());

    return Obx(() {
      final selectedRoom = roomsController.selectedRoom.value;
      if (selectedRoom == null) {
        return Center(
          child: Text(
            "Select a room to start chatting",
            style: TextStyle(color: Pallet.font3),
          ),
        );
      }

      return DropTarget(
        enable: true,
        onDragEntered: (details) {
          messagesController.isDragging.value = true;
        },
        onDragExited: (details) {
          messagesController.isDragging.value = false;
        },
        onDragDone: (details) {
          messagesController.isDragging.value = false;
          final files = details.files.map((xFile) => File(xFile.path)).toList();
          messagesController.addAttachedFiles(files);
        },
        child: Stack(
          children: [
            GlassMorph(
              borderRadius: 24,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ProfileIcon(
                          name: selectedRoom.roomName ?? "",
                          size: 32,
                          fontSize: 14,
                          color: Colors.red,
                          style: ProfileIconStyle.outlined,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          selectedRoom.roomName ?? "",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        SvgPicture.asset(
                          "assets/icons/video_call.svg",
                          width: 25,
                          colorFilter: ColorFilter.mode(
                            Pallet.font3,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 18),
                        SvgPicture.asset(
                          "assets/icons/phone.svg",
                          width: 25,
                          colorFilter: ColorFilter.mode(
                            Pallet.font3,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 18),
                        InkWell(
                          onTap: () {
                            // openEndDrawer("audio");
                          },
                          child: SvgPicture.asset(
                            "assets/icons/audio.svg",
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              Pallet.font3,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        InkWell(
                          onTap: () {
                            // openEndDrawer("image");
                          },
                          child: SvgPicture.asset(
                            "assets/icons/image.svg",
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              Pallet.font3,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        InkWell(
                          onTap: () {
                            // openEndDrawer("file");
                          },
                          child: SvgPicture.asset(
                            "assets/icons/file.svg",
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              Pallet.font3,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        InkWell(
                          onTap: () {
                            // openEndDrawer("search");
                          },
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              Pallet.font3,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        if (!messagesController.showFilePreview.value)
                          ListView.builder(
                            reverse: true,
                            itemCount: messagesController.messages.length,
                            itemBuilder: (context, index) {
                              final msg = messagesController.messages[index];
                              return MessageBubble(
                                message: msg.message,
                                isMe: true, // TODO: Replace with actual logic
                                createdAt: msg.createdAt,
                              );
                            },
                          ),
                        const FilePreviewOverlay(),
                      ],
                    ),
                  ),
                  const Keyboard(),
                ],
              ),
            ),
            if (messagesController.isDragging.value)
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 64,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Drop files here',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Images, Videos, and Audio files',
                          style: TextStyle(
                            color: Colors.blue.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final roomsController = Get.put(RoomsController());
      final selected = roomsController.selectedRoom.value;
      if (selected == null) return const SizedBox.shrink();

      final messagesController = Get.put(MessagesController());

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Attached files preview
          if (messagesController.attachedFiles.isNotEmpty &&
              !messagesController.showFilePreview.value)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Attached Files (${messagesController.attachedFiles.length})',
                        style: TextStyle(
                          color: Pallet.font3,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => messagesController.clearAttachedFiles(),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Pallet.font3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: messagesController.attachedFiles.map((file) {
                      return _AttachedFileChip(
                        file: file,
                        onRemove: () =>
                            messagesController.removeAttachedFile(file),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 5,
                  top: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Pallet.font3,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: messagesController.messageController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        onSubmitted: (value) {
                          if (messagesController.attachedFiles.isNotEmpty) {
                            messagesController.sendMessageWithAttachments();
                          } else {
                            messagesController.sendMessage(
                              messageText: value,
                              messageType: MessageType.text,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            color: Pallet.font3.withValues(alpha: 0.7),
                            fontSize: 13,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 10,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.mic_none, color: Pallet.font3, size: 22),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () async {
                        // Open file picker for manual file selection
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: [
                            // Images
                            'jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp',
                            // Videos
                            'mp4', 'mov', 'avi', 'mkv', 'webm',
                            // Audio
                            'mp3', 'wav', 'm4a', 'flac', 'aac', 'ogg',
                          ],
                        );

                        if (result != null) {
                          final files = result.paths
                              .where((path) => path != null)
                              .map((path) => File(path!))
                              .toList();
                          messagesController.addAttachedFiles(files);
                        }
                      },
                      child: Icon(
                        Icons.attach_file,
                        color: Pallet.font3,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        if (messagesController.attachedFiles.isNotEmpty) {
                          messagesController.sendMessageWithAttachments();
                        } else {
                          messagesController.sendMessage(
                            messageText:
                                messagesController.messageController.text,
                            messageType: MessageType.text,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0084FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _AttachedFileChip extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const _AttachedFileChip({
    required this.file,
    required this.onRemove,
  });

  IconData _getFileIcon() {
    final path = file.path.toLowerCase();
    if (path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.gif') ||
        path.endsWith('.webp')) {
      return Icons.image;
    } else if (path.endsWith('.mp4') ||
        path.endsWith('.mov') ||
        path.endsWith('.avi') ||
        path.endsWith('.mkv')) {
      return Icons.video_file;
    } else if (path.endsWith('.mp3') ||
        path.endsWith('.wav') ||
        path.endsWith('.m4a') ||
        path.endsWith('.flac')) {
      return Icons.audio_file;
    }
    return Icons.insert_drive_file;
  }

  String _getFileName() {
    final name = file.path.split(Platform.pathSeparator).last;
    if (name.length > 20) {
      return '${name.substring(0, 17)}...';
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFileIcon(),
            size: 16,
            color: Pallet.font3,
          ),
          const SizedBox(width: 6),
          Text(
            _getFileName(),
            style: TextStyle(
              color: Pallet.font3,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 6),
          InkWell(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14,
              color: Pallet.font3,
            ),
          ),
        ],
      ),
    );
  }
}
