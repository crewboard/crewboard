import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../controllers/sidebar_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../main.dart'; // For sessionManager
import 'chat_widgets.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../memory_bank/memory_bank_screen.dart';
import 'ticket_threads_full_view.dart';
import 'file_preview_overlay.dart';
import '../../widgets/chat_input_keyboard.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subPage = ref.watch(sidebarProvider.select((s) => s.subPage));

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
      ],
    );
  }
}

class Messages extends ConsumerWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsState = ref.watch(roomsProvider);
    final messagesState = ref.watch(messagesProvider);
    final messagesNotifier = ref.read(messagesProvider.notifier);
    final selectedRoom = roomsState.selectedRoom;

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
        messagesNotifier.setIsDragging(true);
      },
      onDragExited: (details) {
        messagesNotifier.setIsDragging(false);
      },
      onDragDone: (details) {
        messagesNotifier.setIsDragging(false);
        final files = details.files.map((xFile) => File(xFile.path)).toList();
        messagesNotifier.addAttachedFiles(files);
      },
      child: Stack(
        children: [
          GlassMorph(
            borderRadius: 24,
            padding: const EdgeInsets.only(top: 0, bottom: 10),
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
                        color: Pallet.getRoomColor(
                          selectedRoom,
                          sessionManager.authInfo?.authUserId,
                        ),
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
                Container(height: 1, color: Pallet.divider.withOpacity(0.1)),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            if (!messagesState.showFilePreview)
                              ListView.builder(
                                reverse: true,
                                itemCount: messagesState.messages.length,
                                itemBuilder: (context, index) {
                                  final msg = messagesState.messages[index];
                                  bool sameUser = false;
                                  if (index + 1 <
                                      messagesState.messages.length) {
                                    final olderMsg =
                                        messagesState.messages[index + 1];
                                    if (olderMsg.userId == msg.userId) {
                                      sameUser = true;
                                    }
                                  }
                                  return MessageBubble(
                                    chatMessage: msg,
                                    sameUser: sameUser,
                                  );
                                },
                              ),
                            const FilePreviewOverlay(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Keyboard(),
              ],
            ),
          ),
          if (messagesState.isDragging)
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
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
                      const Icon(
                        Icons.file_upload_outlined,
                        size: 64,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      const Text(
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
                          color: Colors.blue.withOpacity(0.8),
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
  }
}

class Keyboard extends ConsumerStatefulWidget {
  const Keyboard({super.key});

  @override
  ConsumerState<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends ConsumerState<Keyboard> {
  late final FocusNode _messageFocusNode;

  @override
  void initState() {
    super.initState();
    _messageFocusNode = FocusNode(
      onKeyEvent: (node, event) {
        return ref.read(messagesProvider.notifier).handleKeyEvent(node, event);
      },
    );
  }

  @override
  void dispose() {
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roomsState = ref.watch(roomsProvider);
    final selected = roomsState.selectedRoom;
    if (selected == null) return const SizedBox.shrink();

    final messagesState = ref.watch(messagesProvider);
    final messagesNotifier = ref.read(messagesProvider.notifier);

    return ChatInputKeyboard(
      controller: messagesNotifier.messageController,
      focusNode: _messageFocusNode,
      typingUserNames: messagesState.typingUsers
          .map((e) => e.userName)
          .toList(),
      showAutocomplete: messagesState.showAutocomplete,
      autocompleteEmojis: messagesState.autocompleteEmojis,
      selectedAutocompleteIndex: messagesState.selectedAutocompleteIndex,
      reply: messagesState.reply,
      onCancelReply: () => messagesNotifier.setReply(null),
      onAutocompleteSelected: (emoji) =>
          messagesNotifier.selectEmojiFromAutocomplete(emoji),
      onChanged: (text) => messagesNotifier.onTextChanged(text),
      onSubmitted: (value) {
        if (messagesState.attachedFiles.isNotEmpty) {
          messagesNotifier.sendMessageWithAttachments();
        } else {
          messagesNotifier.sendMessage(
            messageText: value,
            messageType: MessageType.text,
          );
        }
      },
      onSendPressed: () {
        if (messagesState.attachedFiles.isNotEmpty) {
          messagesNotifier.sendMessageWithAttachments();
        } else {
          messagesNotifier.sendMessage(
            messageText: messagesNotifier.messageController.text,
            messageType: MessageType.text,
          );
        }
      },
      onAttachPressed: () async {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: [
            'jpg',
            'jpeg',
            'png',
            'gif',
            'webp',
            'bmp',
            'mp4',
            'mov',
            'avi',
            'mkv',
            'webm',
            'mp3',
            'wav',
            'm4a',
            'flac',
            'aac',
            'ogg',
          ],
        );

        if (result != null) {
          final files = result.paths
              .where((path) => path != null)
              .map((path) => File(path!))
              .toList();
          messagesNotifier.addAttachedFiles(files);
        }
      },
    );
  }
}
