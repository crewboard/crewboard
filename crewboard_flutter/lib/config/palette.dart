import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

StreamController<String> refresh = StreamController<String>.broadcast();
StreamSink<String> get refreshSink => refresh.sink;
Stream<String> get refreshStream => refresh.stream;

StreamController<String> request = StreamController<String>.broadcast();
StreamSink<String> get requestSink => request.sink;
Stream<String> get requestStream => request.stream;

StreamController<String> message = StreamController<String>.broadcast();
StreamSink<String> get messageSink => message.sink;
Stream<String> get messageStream => message.stream;

enum CurrentPage { chat, flowie, planner, settings }

class Window {
  static double width = 0;
  static double height = 0;
  static double sideBarWidth = 280;
  static Rx<String> subPage = ''.obs;
  static bool active = true;
}

class Pallet {
  static Color theme = Colors.black;
  static const Color background = Color(0xFFFAFAFA);
  static const Color insideFont = Color(0xFF1F2937);

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0C3748), Color(0xFF15212A)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static Color divider = const Color(0xFF728b99).withValues(alpha: 0.3);
  static const Color font1 = Color(0xFFe6e8ed);
  static const Color font2 = Color(0xFFc9ccd3);
  static const Color font3 = Color(0xFF728b99);

  static Color inside1 = Colors.white.withValues(alpha: 0.1);
  static Color inside2 = Colors.white.withValues(alpha: 0.1);
  static Color inside3 = Colors.white.withValues(alpha: 0.1);
}
