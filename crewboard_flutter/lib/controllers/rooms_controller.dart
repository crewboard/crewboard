import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import '../../main.dart'; // For client

class RoomsController extends GetxController {
  final RxList<ChatRoom> rooms = <ChatRoom>[].obs;
  final RxList<User> users = <User>[].obs;
  final RxList<ChatRoom> _backup = <ChatRoom>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearchingUsers = false.obs;
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
    users.clear();
  }

  Future<void> searchRooms(String query) async {
    if (query.isEmpty) {
      resetSearch();
      return;
    }

    // 1. Filter existing rooms locally
    final lower = query.toLowerCase();
    final filtered = _backup.where((room) {
      return (room.roomName ?? '').toLowerCase().contains(lower);
    }).toList();
    rooms.assignAll(filtered);

    // 2. Search for users on the server
    isSearchingUsers.value = true;
    try {
      final foundUsers = await client.chat.searchUsers(query);

      // Filter out users who already have a direct room visible in the room list
      final existingRoomUserNames = _backup
          .where((r) => r.roomType == 'direct')
          .map((r) => r.roomName?.toLowerCase())
          .toSet();

      users.assignAll(
        foundUsers.where(
          (u) => !existingRoomUserNames.contains(u.userName.toLowerCase()),
        ),
      );
    } catch (e) {
      debugPrint('Error searching users: $e');
    } finally {
      isSearchingUsers.value = false;
    }
  }

  void selectRoom(ChatRoom room) {
    selectedRoom.value = room;
  }

  Future<void> startDirectChat(User user) async {
    try {
      isLoading.value = true;
      final room = await client.chat.createDirectRoom(user.id!);

      // Update local lists
      if (!_backup.any((r) => r.id == room.id)) {
        _backup.add(room);
        _backup.sort((a, b) => (a.roomName ?? '').compareTo(b.roomName ?? ''));
      }

      resetSearch();
      selectRoom(room);

      // The Rooms widget will handle navigation to "messages" via Window.subPage
    } catch (e) {
      debugPrint('Error starting direct chat: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
