import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'config/app_config.dart';
import 'config/palette.dart';
import 'controllers/auth_controller.dart';
import 'screens/home.dart';
import 'screens/auth/signin_page.dart';

late final Client client;
late final FlutterAuthSessionManager sessionManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load config
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final config = await AppConfig.loadConfig();
  final serverUrl = serverUrlFromEnv.isEmpty
      ? config.apiUrl ?? 'http://localhost:8080/'
      : serverUrlFromEnv;

  // Initialize modular Session Manager
  sessionManager = FlutterAuthSessionManager();

  client = Client(
    serverUrl,
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // Set the session manager for the client
  client.authKeyProvider = sessionManager;
  client.authSessionManager = sessionManager;

  // Try to initialize session manager, but handle invalid cached data
  try {
    await sessionManager.initialize();

    // Also check if the stored auth is valid by checking if we're authenticated
    if (sessionManager.isAuthenticated) {
      print('Session restored, validating with server...');
      try {
        // Attempt a lightweight server call to validate the session
        // We use 'status' endpoint which is standard in Serverpod auth
        await client.modules.auth.status.getUserInfo();
        print('Session validation successful.');
      } catch (e) {
        print('Session validation message: $e');

        // Only sign out if we are SURE the session is invalid (401/403)
        // If it's a network error or 500, we keep the local session.
        if (e.toString().contains('401') ||
            e.toString().contains('403') ||
            e.toString().contains('Not authenticated')) {
          print('Authentication invalid. Clearing invalid cached auth data...');
          await sessionManager.signOutDevice();
        } else {
          print(
            'Server error or network issue. Keeping local session for retry.',
          );
        }
      }
    }
  } catch (e) {
    // If initialization fails fundamentally, clear and reinitialize
    print('Session initialization failed: $e');
    await sessionManager.signOutDevice();
    await sessionManager.initialize();
  }

  runApp(const MyApp());

  // Window setup for Desktop
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    // appWindow.size = initialSize; // Let OS decide or restore
    appWindow.alignment = Alignment.center;
    appWindow.title = "Crewboard";
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crewboard',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          const TextTheme(
            displayLarge: TextStyle(color: Color(0xFF2C3E50)),
            displayMedium: TextStyle(color: Color(0xFF2C3E50)),
            bodyMedium: TextStyle(color: Color(0xFF7F8C8D)),
            titleMedium: TextStyle(color: Color(0xFF2C3E50)),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    // Initialize Window dimensions for sidebar
    Window.height = MediaQuery.of(context).size.height;
    print(
      'AppEntry Build: isAuthenticated=${authController.isAuthenticated.value}',
    );

    return Obx(() {
      if (!authController.isAuthenticated.value) {
        return SignInPage(
          onSignIn: () {
            print('APP_ENTRY: onSignIn callback triggered');
            authController.checkStatus();
          },
        );
      }
      return const Home();
    });
  }
}
