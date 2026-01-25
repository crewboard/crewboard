import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isAuthenticated = false.obs;
  Rx<UuidValue?> currentUserId = Rx<UuidValue?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize with current session state
    isAuthenticated.value = sessionManager.isAuthenticated;
    _updateUserId();

    // Listen to session changes
    sessionManager.authInfoListenable.addListener(_onSessionChanged);
  }

  void _onSessionChanged() {
    print('AUTH: Session changed event received.');
    print('AUTH: IsAuthenticated status: ${sessionManager.isAuthenticated}');
    isAuthenticated.value = sessionManager.isAuthenticated;
    _updateUserId();
  }

  void checkStatus() {
    print('AUTH: Manual status check requested.');
    // Don't override if already authenticated (forced login)
    if (!isAuthenticated.value) {
      isAuthenticated.value = sessionManager.isAuthenticated;
    }
    _updateUserId();
  }

  void _updateUserId() {
    if (sessionManager.isAuthenticated) {
      // serverpod_auth_core_flutter's sessionManager stores the user ID in the auth info
      final authInfo = sessionManager.authInfoListenable.value;
      if (authInfo != null) {
        currentUserId.value = authInfo.authUserId;
      }
    } else {
      currentUserId.value = null;
    }
  }

  void forceAuthenticated() {
    print('AUTH: Forcing authenticated state to true.');
    isAuthenticated.value = true;
  }

  @override
  void onClose() {
    sessionManager.authInfoListenable.removeListener(_onSessionChanged);
    super.onClose();
  }

  Future<void> logout() async {
    await sessionManager.signOutDevice();
  }
}
