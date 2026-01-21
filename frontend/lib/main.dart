import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:frontend/backend/event_server.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/emoji_database_service.dart';
import 'screens/auth/signup_page.dart';
import 'screens/auth/signin_page.dart';
import 'screens/home.dart' as app_home;
// import 'screens/flows/main.dart' as flow_editor;
import 'services/local_storage_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/globals.dart';
import 'backend/server.dart';
import 'package:get/get.dart';
import 'backend/provider/sidebar_controller.dart';
import 'package:frontend/screens/admin/admin_router_controller.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'dart:io';
import 'package:media_kit/media_kit.dart';

class AuthController extends GetxController {
  RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final userId = await LocalStorageService.getUserId();
    isAuthenticated.value = userId != null;
  }

  Future<void> logout() async {
    await LocalStorageService.clearUserData();
    isAuthenticated.value = false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MediaKit
  MediaKit.ensureInitialized();

  // Check if codec pack is already installed
  await LocalStorageService.ensureCodecPackInstalled();

  // Sync emojis in background
  try {
    await emojiDatabaseService.syncEmojis();
  } catch (e) {
    print('Error syncing emojis on startup: $e');
  }

  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "NodePath";
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NodePath',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          TextTheme(
            displayLarge: TextStyle(color: const Color(0xFF2C3E50)),
            displayMedium: TextStyle(color: const Color(0xFF2C3E50)),
            bodyMedium: TextStyle(color: const Color(0xFF7F8C8D)),
            titleMedium: TextStyle(color: const Color(0xFF2C3E50)),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      localizationsDelegates: [FlutterQuillLocalizations.delegate],
      home: const AppEntry(),
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.put(AuthController());
    Get.put(SidebarController());
    Get.put(AdminRouterController());
  }

  @override
  Widget build(BuildContext context) {
    Window.width = MediaQuery.of(context).size.width;
    Window.height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (!authController.isAuthenticated.value) {
        return SignInPage(
          onSignIn: () async {
            // Refresh auth status after successful sign-in
            await authController.checkAuthStatus();
          },
        );
      }

      // If authenticated, navigate to Home
      return app_home.Home();
    });
  }
}
