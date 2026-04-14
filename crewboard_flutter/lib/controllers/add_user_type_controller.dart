import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'dart:convert';
import '../main.dart';
import 'users_controller.dart';

class AddUserTypeState {
  final SystemColor? selectedColor;
  final Map<String, bool> permissions;
  final bool isLoading;
  final List<SystemColor> colorsList;
  final UuidValue? editingId;

  AddUserTypeState({
    this.selectedColor,
    this.permissions = const {
      'manage_users': false,
      'manage_user_data': false,
      'manage_chat': false,
      'manage_planner': false,
      'manage_flowie': false,
    },
    this.isLoading = false,
    this.colorsList = const [],
    this.editingId,
  });

  AddUserTypeState copyWith({
    SystemColor? selectedColor,
    Map<String, bool>? permissions,
    bool? isLoading,
    List<SystemColor>? colorsList,
    UuidValue? editingId,
    bool clearEditingId = false,
  }) {
    return AddUserTypeState(
      selectedColor: selectedColor ?? this.selectedColor,
      permissions: permissions ?? this.permissions,
      isLoading: isLoading ?? this.isLoading,
      colorsList: colorsList ?? this.colorsList,
      editingId: clearEditingId ? null : (editingId ?? this.editingId),
    );
  }
}

final addUserTypeProvider = NotifierProvider<AddUserTypeNotifier, AddUserTypeState>(AddUserTypeNotifier.new);

class AddUserTypeNotifier extends Notifier<AddUserTypeState> {
  final nameController = TextEditingController();

  @override
  AddUserTypeState build() {
    Future.microtask(() => loadColors());
    ref.onDispose(() => nameController.dispose());
    return AddUserTypeState();
  }

  Future<void> loadColors() async {
    try {
      final fetchedColors = await client.admin.getColors();
      SystemColor? defaultColor;
      if (fetchedColors.isNotEmpty) {
        defaultColor = fetchedColors.firstWhere((c) => c.isDefault, orElse: () => fetchedColors.first);
      }
      state = state.copyWith(colorsList: fetchedColors, selectedColor: defaultColor);
    } catch (e) {
      debugPrint("Error fetching colors: $e");
    }
  }

  void initFrom(UserTypes existing) {
    nameController.text = existing.userType;
    
    Map<String, bool> permissions = Map<String, bool>.from(state.permissions);
    try {
      final decoded = jsonDecode(existing.permissions);
      if (decoded is Map) {
        decoded.forEach((key, value) {
          if (permissions.containsKey(key)) {
            permissions[key] = value == true;
          }
        });
      }
    } catch (e) {
      debugPrint("Error decoding permissions: $e");
    }

    SystemColor? color;
    if (state.colorsList.isNotEmpty) {
      color = state.colorsList.firstWhere(
        (c) => c.id == existing.colorId,
        orElse: () => state.colorsList.first,
      );
    }

    state = state.copyWith(
      permissions: permissions,
      selectedColor: color,
      editingId: existing.id,
    );
  }

  void selectColor(SystemColor color) => state = state.copyWith(selectedColor: color);

  void togglePermission(String key) {
    final permissions = Map<String, bool>.from(state.permissions);
    permissions[key] = !(permissions[key] ?? false);
    state = state.copyWith(permissions: permissions);
  }

  Future<bool> addUserType() async {
    if (nameController.text.isEmpty) return false;
    if (state.selectedColor == null) return false;

    state = state.copyWith(isLoading: true);
    try {
      final userType = UserTypes(
        id: state.editingId,
        userType: nameController.text,
        colorId: state.selectedColor!.id!,
        permissions: jsonEncode(state.permissions),
        isAdmin: state.permissions['manage_users'] ?? false,
      );

      await client.admin.addUserType(userType);
      
      // Refresh users list and user types
      ref.read(usersProvider.notifier).fetchData();
      
      return true;
    } catch (e) {
      debugPrint("Error adding user type: $e");
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void reset() {
    nameController.clear();
    state = AddUserTypeState(
      colorsList: state.colorsList,
      selectedColor: state.selectedColor,
      editingId: null,
    );
  }
}
