import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/screens/chats/chat_widgets.dart' hide Message;
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

enum CurrentPage { chat, flowie, planner, settings }

StreamController<String> refresh = StreamController<String>.broadcast();
StreamSink<String> get refreshSink => refresh.sink;
Stream<String> get refreshStream => refresh.stream;

StreamController<String> request = StreamController<String>.broadcast();
StreamSink<String> get requestSink => request.sink;
Stream<String> get requestStream => request.stream;

StreamController<String> message = StreamController<String>.broadcast();
StreamSink<String> get messageSink => message.sink;
Stream<String> get messageStream => message.stream;

// Map incoming = {};

// Simple database mock

int plannerCount = 0;

class Window {
  static double width = 0;
  static double height = 0;
  // static double stageWidth = 0;

  static double sideBarWidth = 280;
  static Rx<String> subPage = ''.obs;
  static bool active = true;
}

class Pallet {
  static Color theme = Colors.black; // Primary blue
  static Color background = Color(0xFFFAFAFA); // Light gray background
  static Color insideFont = Color(0xFF1F2937); // Dark gray text

  // Background gradient between #0C3748 and #15212A
  static LinearGradient backgroundGradient = const LinearGradient(
    colors: [Color(0xFF0C3748), Color(0xFF15212A)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static Color divider = Color(
    0xFF728b99,
  ).withOpacity(0.3); // Medium gray for secondary text

  static Color font1 = Color(0xFFe6e8ed); // Medium gray for secondary text
  static Color font2 = Color(0xFFc9ccd3); // Dark gray for primary text
  static Color font3 = Color(0xFF728b99); // Light gray for tertiary text

  static Color inside1 = Colors.white.withOpacity(
    0.1,
  ); // Pure white for cards/containers
  static Color inside2 = Colors.white.withOpacity(
    0.1,
  ); // Light gray for secondary containers
  static Color inside3 = Colors.white.withOpacity(0.1); // Border/divider color
}

// Global app context
