import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import '../../main.dart'; // For client

class RoomsController extends GetxController {
  final RxList<ChatRoom> rooms = <ChatRoom>[].obs;
  final RxList<ChatRoom> _backup = <ChatRoom>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ChatRoom?> selectedRoom = Rx<ChatRoom?>(null);

  @override
  void onInit() {
    super.onInit();
    loadRooms();
  }

  Future<void> loadRooms() async {
    try {
      isLoading.value = true;
      final response = await client.chat.getRooms();
      rooms.assignAll(response);
      _backup.assignAll(response);
    } catch (e) {
      debugPrint('Error getting rooms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetSearch() {
    rooms.assignAll(_backup);
  }

  void searchRooms(String query) {
    if (query.isEmpty) {
      resetSearch();
      return;
    }
    final lower = query.toLowerCase();
    final filtered = _backup.where((room) {
      return (room.roomName ?? '').toLowerCase().contains(lower);
    }).toList();
    rooms.assignAll(filtered);
  }

  void selectRoom(ChatRoom room) {
    selectedRoom.value = room;
  }
}
