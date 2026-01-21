import 'package:get/get.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/globals.dart' as g;
import 'package:frontend/screens/chats/chat_widgets.dart' hide Message;
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/local_storage_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/backend/media_server.dart';
import 'dart:convert';
import 'package:frontend/screens/chats/rooms_controller.dart';
import 'package:frontend/globals.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/emoji_database_service.dart';

extension GreetExtension on Room {
  RoomProfile getUser(String id) {
    for (var user in this.roomUsers) {
      if (user.userId == id) {
        return user;
      }
    }
    return RoomProfile.empty();
  }
}

class MessagesController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<PlatformFile> pendingFiles = <PlatformFile>[].obs;
  final RxBool showFilePreview = false.obs;

  // Text field controller
  final TextEditingController messageController = TextEditingController();

  // Moved from ChatManager
  Message? reply;
  Message? edit;
  Message? message;
  String lastMessage = '';
  int limit = 50;

  // Scroll controllers and listeners
  final ItemScrollController controller = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  Future<void> loadInitialMessages({required String roomId}) async {
    await _loadMessages(roomId: roomId);
  }

  Future<void> loadTopMessages({
    required String roomId,
    required String anchorMessageId,
  }) async {
    await _loadMessages(roomId: roomId, messageId: anchorMessageId);
  }

  buildMessage(dynamic message) {}

  Future<void> sendMessage({
    dynamic message,
    required MessageType messageType,
  }) async {
    final hasController = Get.isRegistered<RoomsController>();
    if (!hasController) return;
    final selected = Get.find<RoomsController>().selectedRoom.value;
    if (selected == null) return;
    dynamic messageContent = [];

    if (messageType == MessageType.text) {
      final messageText = message?.trim() ?? '';
      final hasText = messageText.isNotEmpty;
      final hasFiles = pendingFiles.value.isNotEmpty;

      if (!hasText && !hasFiles) return;

      // Get userId from local storage or globals
      String? userId = await LocalStorageService.getUserId();
      if (userId == null || userId.isEmpty) {
        print('Error: No user ID available');
        return;
      }

      try {
        // Handle text content
        if (hasText) {
          messageContent = await buildTextMessage(messageText);
        }

        // Handle file uploads
        if (hasFiles) {
          for (var file in pendingFiles.value!) {
            if (file.bytes != null) {
              final uploadedUrl = await MediaServer.uploadImage(
                originalName: file.name,
                bytes: file.bytes!,
              );
              if (uploadedUrl != null) {
                // Determine message type based on file extension
                messageType = MessageType.file;
                if (file.extension != null) {
                  final ext = file.extension!.toLowerCase();
                  if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) {
                    messageType = MessageType.image;
                  } else if (['mp4', 'avi', 'mov', 'mkv'].contains(ext)) {
                    messageType = MessageType.video;
                  } else if (['mp3', 'wav', 'aac'].contains(ext)) {
                    messageType = MessageType.audio;
                  }
                }

                messageContent.add({
                  "type": messageType,
                  "value": uploadedUrl,
                  "name": file.name,
                  "size": file.size,
                });
              }
            }
          }
        }

        // Trigger UI refresh
        // refreshSink.add("");
      } catch (e) {
        print('Error sending message: $e');
      }
    } else if (messageType == MessageType.gif) {
      messageContent = message;
    }

    final params = SendMessageParams(
      roomId: selected.roomId,
      message: jsonEncode(messageContent),
      messageType: messageType,
      parentMessageId: reply?.messageId,
    );

    await server.chats.sendMessage(params);

    // Clear input and reply
    messageController.clear();
    reply = null;

    // Reset typing state (if applicable)

    // Reload messages
    loadInitialMessages(roomId: selected.roomId);

    // Clear pending files and hide preview
    pendingFiles.clear();
    showFilePreview.value = false;
  }

  Future<void> _loadMessages({
    required String roomId,
    String? messageId,
  }) async {
    try {
      isLoading.value = true;
      String? userId = await LocalStorageService.getUserId();
      if (userId == null || userId.isEmpty) {
        return;
      }

      final response = await server.chats.getMessages(
        GetMessagesParams(
          roomId: roomId,
          limit: limit.toDouble(),
          messageId: messageId,
        ),
      );

      final List<Message> mapped = response.messages.map((m) {
        return m;
      }).toList();

      // Backend returns most-recent-first for chat view using reverse=true
      // Ensure list order matches UI expectation (reverse list widget). Keep as-is.
      messages.assignAll(mapped);

      // Set last message ID for UI logic
      if (mapped.isNotEmpty) {
        lastMessage = mapped.last.messageId;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error loading messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Map<String, dynamic>>> buildTextMessage(String text) async {
    final List<Map<String, dynamic>> result = [];
    final List<Map<String, dynamic>> emojis = await emojiDatabaseService
        .getAllEmojis();

    // Build a set of emoji strings (grapheme cluster form)
    final Set<String> emojiSet = emojis
        .where((e) => e['emoji'] != null)
        .map((e) => (e['emoji'] as String))
        .toSet();

    final buffer = StringBuffer();

    for (final cluster in text.characters) {
      if (emojiSet.contains(cluster)) {
        // Flush any pending text
        if (buffer.isNotEmpty) {
          result.add({"type": "text", "value": buffer.toString()});
          buffer.clear();
        }
        // Add the emoji
        result.add({"type": "emoji", "value": cluster});
      } else {
        // accumulate normal text
        buffer.write(cluster);
      }
    }

    // flush trailing text
    if (buffer.isNotEmpty) {
      result.add({"type": "text", "value": buffer.toString()});
    }

    print(result);
    return result;
  }
}
