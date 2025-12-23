import 'package:crewboard_flutter/main.dart';
import 'package:get/get.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

class AuthController extends GetxController {
  RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with current session state
    isAuthenticated.value = sessionManager.isAuthenticated;
    
    // Listen to session changes
    sessionManager.authInfoListenable.addListener(_onSessionChanged);
  }

  void _onSessionChanged() {
    isAuthenticated.value = sessionManager.isAuthenticated;
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
