import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import '../../main.dart'; // For client

class RoomsState {
  final List<ChatRoom> rooms;
  final List<User> users;
  final List<ChatRoom> backup;
  final bool isLoading;
  final bool isSearchingUsers;
  final ChatRoom? selectedRoom;
  final String searchQuery;

  RoomsState({
    this.rooms = const [],
    this.users = const [],
    this.backup = const [],
    this.isLoading = false,
    this.isSearchingUsers = false,
    this.selectedRoom,
    this.searchQuery = "",
  });

  RoomsState copyWith({
    List<ChatRoom>? rooms,
    List<User>? users,
    List<ChatRoom>? backup,
    bool? isLoading,
    bool? isSearchingUsers,
    ChatRoom? selectedRoom,
    String? searchQuery,
    bool clearSelectedRoom = false,
  }) {
    return RoomsState(
      rooms: rooms ?? this.rooms,
      users: users ?? this.users,
      backup: backup ?? this.backup,
      isLoading: isLoading ?? this.isLoading,
      isSearchingUsers: isSearchingUsers ?? this.isSearchingUsers,
      selectedRoom: clearSelectedRoom ? null : (selectedRoom ?? this.selectedRoom),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final roomsProvider = NotifierProvider<RoomsNotifier, RoomsState>(RoomsNotifier.new);

class RoomsNotifier extends Notifier<RoomsState> {
  @override
  RoomsState build() {
    Future.microtask(() => loadRooms());
    return RoomsState();
  }

  Future<void> loadRooms() async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await client.chat.getRooms();
      state = state.copyWith(
        rooms: response,
        backup: response,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('Error getting rooms: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void resetSearch() {
    state = state.copyWith(
      searchQuery: "",
      rooms: state.backup,
      users: [],
    );
  }

  Future<void> searchRooms(String query) async {
    state = state.copyWith(searchQuery: query);
    if (query.isEmpty) {
      resetSearch();
      return;
    }

    // 1. Filter existing rooms locally
    final lower = query.toLowerCase();
    final filtered = state.backup.where((room) {
      return (room.roomName ?? '').toLowerCase().contains(lower);
    }).toList();
    
    state = state.copyWith(rooms: filtered, isSearchingUsers: true);

    // 2. Search for users on the server
    try {
      final foundUsers = await client.chat.searchUsers(query);

      // Filter out users who already have a direct room visible in the room list
      final existingRoomUserNames = state.backup
          .where((r) => r.roomType == 'direct')
          .map((r) => r.roomName?.toLowerCase())
          .toSet();

      final filteredUsers = foundUsers.where(
        (u) => !existingRoomUserNames.contains(u.userName.toLowerCase()),
      ).toList();

      state = state.copyWith(users: filteredUsers, isSearchingUsers: false);
    } catch (e) {
      debugPrint('Error searching users: $e');
      state = state.copyWith(isSearchingUsers: false);
    }
  }

  void selectRoom(ChatRoom? room) {
    if (room == null) {
      state = state.copyWith(clearSelectedRoom: true);
    } else {
      state = state.copyWith(selectedRoom: room);
    }
  }

  Future<void> startDirectChat(User user) async {
    try {
      state = state.copyWith(isLoading: true);
      final room = await client.chat.createDirectRoom(user.id!);

      // Update local lists
      final updatedBackup = List<ChatRoom>.from(state.backup);
      int index = updatedBackup.indexWhere((r) => r.id == room.id);
      if (index != -1) {
        updatedBackup[index] = room;
      } else {
        updatedBackup.add(room);
      }
      updatedBackup.sort((a, b) => (a.roomName ?? '').compareTo(b.roomName ?? ''));

      state = state.copyWith(
        backup: updatedBackup,
        isLoading: false,
        selectedRoom: room,
        searchQuery: "",
        rooms: updatedBackup,
        users: [],
      );
    } catch (e) {
      debugPrint('Error starting direct chat: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> markAsRead(ChatRoom room) async {
    try {
      await client.chat.markAsRead(room.id!);
      // Update local state to immediately hide the badge
      final updatedRooms = state.rooms.map((r) {
        if (r.id == room.id) {
          return r.copyWith(messageCount: 0);
        }
        return r;
      }).toList();
      state = state.copyWith(rooms: updatedRooms);
    } catch (e) {
      debugPrint('Error marking room as read: $e');
    }
  }

  void updateLastMessage(UuidValue roomId, ChatMessage message) {
    final updatedRooms = List<ChatRoom>.from(state.rooms);
    int index = updatedRooms.indexWhere((r) => r.id == roomId);
    if (index != -1) {
      var updatedRoom = updatedRooms[index].copyWith(lastMessage: message);
      updatedRooms.removeAt(index);
      updatedRooms.insert(0, updatedRoom);
    }

    final updatedBackup = List<ChatRoom>.from(state.backup);
    int backupIndex = updatedBackup.indexWhere((r) => r.id == roomId);
    if (backupIndex != -1) {
      var updatedBackupRoom = updatedBackup[backupIndex].copyWith(
        lastMessage: message,
      );
      updatedBackup.removeAt(backupIndex);
      updatedBackup.insert(0, updatedBackupRoom);
    }

    state = state.copyWith(rooms: updatedRooms, backup: updatedBackup);
  }
}
