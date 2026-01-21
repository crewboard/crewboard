import '../services/arri_client.rpc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/screens/admin/admin_router_controller.dart';
import 'dart:io' show Platform;
import 'package:frontend/services/local_storage_service.dart';

// Centralized backend base URL for both RPC and manual HTTP calls
const String baseUrl = 'http://192.168.1.5:5000';
const String socketUrl = 'http://192.168.1.5:5001';

final server = ArriClient(
  baseUrl: baseUrl,
  headers: () async {
    final headers = <String, String>{};
    final userId = await LocalStorageService.getUserId();
    final organizationId = await LocalStorageService.getOrganizationId();
    if (userId != null) {
      final token = jsonEncode({
        "id": userId,
        "organizationId": organizationId,
        "name": "jerin",
      });
      headers['Authorization'] = token;
    }
    return headers;
  },
  onError: (error) {
    print('ARRI Client Error: $error');
  },
);

// Extension to add missing methods to ArriClient
extension ArriClientExtension on ArriClient {
  String get deviceType {
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isWindows) return 'windows';
    if (Platform.isLinux) return 'linux';
    if (Platform.isMacOS) return 'macos';
    return 'web';
  }

  // Mock methods for backward compatibility
  // void get({
  //   bool? lock,
  //   Map<String, dynamic>? data,
  //   Function(dynamic)? func,
  // }) {
  //   // TODO: Implement or remove these legacy methods
  //   print('Legacy server.get called with data: $data');
  //   if (func != null) func({});
  // }

  Future<void> lock() async {
    // TODO: Implement or remove
  }

  void release() {
    // TODO: Implement or remove
  }

  void registerListeners({
    required String event,
    required Function(Map<String, dynamic>) func,
  }) {
    // TODO: Implement event listeners
    print('Registering listener for event: $event');
  }

  String getAsssetUrl(String url) {
    return '$baseUrl$url';
  }

  // Chats extras until Arri codegen includes them
  Future<void> seenMessage({
    required String roomId,
    required String userId,
    required String messageId,
  }) async {
    final uri = Uri.parse('$baseUrl/chats/seen-message');
    await http.post(
      uri,
      headers: {"content-type": "application/json"},
      body: jsonEncode({
        "roomId": roomId,
        "userId": userId,
        "messageId": messageId,
      }),
    );
  }
}

final adminRouter = AdminRouterController();

Future<void> registerDeviceWithBackend(
  String userId, {
  String? socketId,
}) async {
  final deviceId = await LocalStorageService.getOrCreateDeviceId();
  final deviceType = Platform.isWindows
      ? 'windows'
      : Platform.isLinux
      ? 'linux'
      : 'mac';
  try {
    final response = await server.auth.updateUserDevice(
      UpdateUserDeviceParams(
        userId: userId,
        deviceId: deviceId,
        deviceType: deviceType,
        socketId: socketId,
      ),
    );
    if (!response.success) {
      throw Exception('Failed to register device');
    }
  } catch (e) {
    // swallow errors; non-fatal
  }
}
