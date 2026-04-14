import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../main.dart';

class UsersState {
  final List<User> users;
  final List<UserTypes> userTypes;
  final bool isLoading;

  UsersState({
    this.users = const [],
    this.userTypes = const [],
    this.isLoading = false,
  });

  UsersState copyWith({
    List<User>? users,
    List<UserTypes>? userTypes,
    bool? isLoading,
  }) {
    return UsersState(
      users: users ?? this.users,
      userTypes: userTypes ?? this.userTypes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final usersProvider = NotifierProvider<UsersNotifier, UsersState>(UsersNotifier.new);

class UsersNotifier extends Notifier<UsersState> {
  @override
  UsersState build() {
    // Fetch data asynchronously after the provider is initialized
    Future.microtask(() => fetchData());
    return UsersState();
  }

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    try {
      final users = await client.admin.getUsers();
      final userTypes = await client.admin.getUserTypes();
      state = state.copyWith(
        users: users,
        userTypes: userTypes,
        isLoading: false,
      );
    } catch (e) {
      // debugPrint("Error fetching users data: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggleUserStatus(User user) async {
    try {
      user.deleted = !user.deleted;
      await client.admin.updateUser(user);
      await fetchData();
    } catch (e) {
      // debugPrint("Error toggling user status: $e");
    }
  }
}
