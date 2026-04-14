import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isAuthenticated;
  final UuidValue? currentUserId;

  AuthState({required this.isAuthenticated, this.currentUserId});

  AuthState copyWith({bool? isAuthenticated, UuidValue? currentUserId}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Initialize with current session state
    final initialState = AuthState(
      isAuthenticated: sessionManager.isAuthenticated,
      currentUserId: _getUserId(),
    );

    // Listen to session changes
    sessionManager.authInfoListenable.addListener(_onSessionChanged);

    // Cleanup when provider is disposed
    ref.onDispose(() {
      sessionManager.authInfoListenable.removeListener(_onSessionChanged);
    });

    return initialState;
  }

  void _onSessionChanged() {
    print('AUTH: Session changed event received.');
    state = state.copyWith(
      isAuthenticated: sessionManager.isAuthenticated,
      currentUserId: _getUserId(),
    );
  }

  UuidValue? _getUserId() {
    if (sessionManager.isAuthenticated) {
      final authInfo = sessionManager.authInfoListenable.value;
      return authInfo?.authUserId;
    }
    return null;
  }

  void checkStatus() {
    print('AUTH: Manual status check requested.');
    if (!state.isAuthenticated) {
      state = state.copyWith(
        isAuthenticated: sessionManager.isAuthenticated,
        currentUserId: _getUserId(),
      );
    }
  }

  void forceAuthenticated() {
    print('AUTH: Forcing authenticated state to true.');
    state = state.copyWith(isAuthenticated: true);
  }

  Future<void> logout() async {
    await sessionManager.signOutDevice();
  }
}
