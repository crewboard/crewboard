import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:mime/mime.dart';
import '../../main.dart'; // For client
import 'rooms_controller.dart';

class MessagesController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isDragging = false.obs;
  final RxList<File> attachedFiles = <File>[].obs;
  final RxBool showFilePreview = false.obs;

  final TextEditingController messageController = TextEditingController();

  Future<void> loadInitialMessages({required UuidValue roomId}) async {
    try {
      isLoading.value = true;
      final response = await client.chat.getMessages(
        roomId,
        limit: 50,
        offset: 0,
      );
      messages.assignAll(response);
    } catch (e) {
      debugPrint('Error loading messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage({
    required String messageText,
    required MessageType messageType,
  }) async {
    final roomsController = Get.find<RoomsController>();
    final selectedRoom = roomsController.selectedRoom.value;
    if (selectedRoom == null) return;

    if (messageText.trim().isEmpty) return;

    final chatMessage = ChatMessage(
      roomId: selectedRoom.id!,
      message: messageText,
      messageType: messageType,
      seenUserList: [],
      sameUser: false,
      deleted: false,
      createdAt: DateTime.now(),
      userId: UuidValue.fromString(
        '00000000-0000-4000-8000-000000000000',
      ), // TODO: Get from auth
    );

    try {
      await client.chat.sendMessage(chatMessage);
      messageController.clear();
      // Optionally reload or wait for stream
      await loadInitialMessages(roomId: selectedRoom.id!);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  void subscribeToRoom(UuidValue roomId) {
    // Implement Serverpod streaming subscription here
    // For now we just reload periodically or manual refresh
  }

  void addAttachedFiles(List<File> files) {
    final validFiles = files.where((file) {
      final mimeType = lookupMimeType(file.path);
      if (mimeType == null) return false;

      return mimeType.startsWith('image/') ||
          mimeType.startsWith('video/') ||
          mimeType.startsWith('audio/');
    }).toList();

    attachedFiles.addAll(validFiles);
    if (validFiles.isNotEmpty) {
      showFilePreview.value = true;
    }
  }

  void removeAttachedFile(File file) {
    attachedFiles.remove(file);
  }

  void clearAttachedFiles() {
    attachedFiles.clear();
    showFilePreview.value = false;
  }

  void closeFilePreview() {
    showFilePreview.value = false;
    // We don't necessarily clear files here if they want to just minimize,
    // but the requirement says "cancel" usually clears.
    // For now, let's keep files but hide overlay, so they can see them in loop bar if needed?
    // Actually init plan said "Cancel" clears. Let's make closeFilePreview just hide, and 'cancel' action can call clear.
  }

  MessageType getMessageTypeFromFile(File file) {
    final mimeType = lookupMimeType(file.path);
    if (mimeType == null) return MessageType.text;

    if (mimeType.startsWith('image/')) return MessageType.image;
    if (mimeType.startsWith('video/')) return MessageType.video;
    if (mimeType.startsWith('audio/')) return MessageType.audio;

    return MessageType.file;
  }

  Future<void> sendMessageWithAttachments() async {
    if (attachedFiles.isEmpty && messageController.text.trim().isEmpty) {
      return;
    }

    // Send text message if present
    if (messageController.text.trim().isNotEmpty) {
      await sendMessage(
        messageText: messageController.text,
        messageType: MessageType.text,
      );
    }

    // Send each file as a separate message
    for (final file in attachedFiles) {
      final messageType = getMessageTypeFromFile(file);
      // TODO: Upload file to server and get URL
      // For now, just send the file path as message
      await sendMessage(
        messageText: file.path,
        messageType: messageType,
      );
    }

    clearAttachedFiles();
    showFilePreview.value = false;
  }
}
