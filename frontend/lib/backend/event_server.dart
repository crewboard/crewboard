import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'server.dart';
import 'package:frontend/services/local_storage_service.dart';

class EventServer {
  static IO.Socket? _socket;
  static bool _isConnected = false;

  /// Initialize the Socket.IO connection and listen to a specific topic
  /// [topic] - The topic/room to listen to
  /// [onData] - Callback function to handle incoming data
  static Future<void> listen({
    required String topic,
    required Function(Map<String, dynamic>) onData,
  }) async {
    print("listening");
    try {
      _socket = IO.io(
        socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            // .enableReconnection()
            // .setReconnectionDelay(1000)
            // .setReconnectionAttempts(5)
            .build(),
      );

      // Connect explicitly
      _socket!.connect();

      _socket!.onConnect((_) async {
        print('Socket.IO connected');
        _isConnected = true;
        // Wait a bit for socket ID to be available
        await Future.delayed(const Duration(milliseconds: 100));
        try {
          final sid = _socket!.id;
          final userId = await LocalStorageService.getUserId();
          print('Socket ID: $sid, User ID: $userId');
          if (sid != null && userId != null) {
            await registerDeviceWithBackend(userId, socketId: sid);
          }
        } catch (e) {
          print('Error registering device: $e');
        }
        _socket!.on("typing", (data) {
          print('Received data on topic $topic: $data');
          onData(Map<String, dynamic>.from(data));
        });
      });

      _socket!.onDisconnect((_) {
        print('Socket.IO disconnected');
        _isConnected = false;
      });

      _socket!.onConnectError((error) {
        print('Socket.IO connection error: $error');
        _isConnected = false;
      });

      // Listen for events on the specified topic
      _socket!.on("typing", (data) {
        print('Received data on topic $topic: $data');
        onData(Map<String, dynamic>.from(data));
      });
      print('Registered topic $topic');

      // Wait for connection
      await _waitForConnection();
    } catch (e) {
      print('Error initializing Socket.IO: $e');
      _isConnected = false;
    }
  }

  /// Wait for the socket connection to be established
  static Future<void> _waitForConnection() async {
    int attempts = 0;
    while (!_isConnected && attempts < 10) {
      await Future.delayed(const Duration(milliseconds: 500));
      attempts++;
    }

    if (!_isConnected) {
      throw Exception('Failed to connect to Socket.IO server');
    }
  }

  /// Get connection status
  static bool get isConnected => _isConnected;

  /// Disconnect from the server
  static void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      _isConnected = false;
      print('Socket.IO disconnected');
    }
  }
}
