import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'config/app_config.dart';
import 'config/palette.dart';
import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
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

  // Open streaming connection for real-time updates
  await client.openStreamingConnection();

  // Try to initialize session manager, but handle invalid cached data
  try {
    await sessionManager.initialize();

    // Also check if the stored auth is valid by checking if we're authenticated
    if (sessionManager.isAuthenticated) {
      print('Session restored, validating with server...');
      try {
        // Attempt a lightweight server call to validate the session
        await client.chat.getRooms();
        print('Session validation successful.');
      } catch (e) {
        print('Session validation message: $e');

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
    print('Session initialization failed: $e');
    await sessionManager.signOutDevice();
    await sessionManager.initialize();
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

  // Window setup for Desktop
  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Crewboard";
    appWindow.show();
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
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

class AppEntry extends ConsumerStatefulWidget {
  const AppEntry({super.key});

  @override
  ConsumerState<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends ConsumerState<AppEntry> {
  @override
  Widget build(BuildContext context) {
    // Initialize Window dimensions for sidebar
    Window.height = MediaQuery.of(context).size.height;
    Window.width = MediaQuery.of(context).size.width;

    final authState = ref.watch(authProvider);

    print(
      'AppEntry Build: isAuthenticated=${authState.isAuthenticated}',
    );

    if (!authState.isAuthenticated) {
      return SignInPage(
        onSignIn: () {
          print('APP_ENTRY: onSignIn callback triggered');
          ref.read(authProvider.notifier).checkStatus();
        },
      );
    }
    return const Home();
  }
}
