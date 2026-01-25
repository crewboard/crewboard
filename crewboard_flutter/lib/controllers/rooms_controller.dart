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
  final RxString searchQuery = "".obs;

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
    searchQuery.value = "";
    rooms.assignAll(_backup);
    users.clear();
  }

  Future<void> searchRooms(String query) async {
    searchQuery.value = query;
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
      int index = _backup.indexWhere((r) => r.id == room.id);
      if (index != -1) {
        _backup[index] = room;
      } else {
        _backup.add(room);
      }
      _backup.sort((a, b) => (a.roomName ?? '').compareTo(b.roomName ?? ''));

      resetSearch();
      selectRoom(room);

      // The Rooms widget will handle navigation to "messages" via Window.subPage
    } catch (e) {
      debugPrint('Error starting direct chat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(ChatRoom room) async {
    try {
      await client.chat.markAsRead(room.id!);
      // Update local state to immediately hide the badge
      int index = rooms.indexWhere((r) => r.id == room.id);
      if (index != -1) {
        rooms[index] = rooms[index].copyWith(messageCount: 0);
        rooms.refresh();
      }
    } catch (e) {
      debugPrint('Error marking room as read: $e');
    }
  }

  void updateLastMessage(UuidValue roomId, ChatMessage message) {
    int index = rooms.indexWhere((r) => r.id == roomId);
    if (index != -1) {
      var updatedRoom = rooms[index].copyWith(lastMessage: message);
      rooms.removeAt(index);
      rooms.insert(0, updatedRoom);
    }

    int backupIndex = _backup.indexWhere((r) => r.id == roomId);
    if (backupIndex != -1) {
      var updatedBackupRoom = _backup[backupIndex].copyWith(lastMessage: message);
      _backup.removeAt(backupIndex);
      _backup.insert(0, updatedBackupRoom);
    }
  }
}
