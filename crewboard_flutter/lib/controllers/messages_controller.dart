import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../main.dart'; // For client
import 'rooms_controller.dart';

class MessagesController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  final TextEditingController messageController = TextEditingController();

  Future<void> loadInitialMessages({required int roomId}) async {
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
      userId: 0, // Will be set by server
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

  void subscribeToRoom(int roomId) {
    // Implement Serverpod streaming subscription here
    // For now we just reload periodically or manual refresh
  }
}
