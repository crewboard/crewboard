import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

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

  // Dynamic colors based on theme
  static Color get divider {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight 
          ? const Color(0xFF728b99).withOpacity(0.3)
          : const Color(0xFF728b99).withOpacity(0.3);
    } catch (e) {
      return const Color(0xFF728b99).withOpacity(0.3);
    }
  }

  static Color get font1 {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight ? const Color(0xFF1F2937) : const Color(0xFFe6e8ed);
    } catch (e) {
      return const Color(0xFFe6e8ed);
    }
  }

  static Color get font2 {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight ? const Color(0xFF4B5563) : const Color(0xFFc9ccd3);
    } catch (e) {
      return const Color(0xFFc9ccd3);
    }
  }

  static Color get font3 {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight ? const Color(0xFF6B7280) : const Color(0xFF728b99);
    } catch (e) {
      return const Color(0xFF728b99);
    }
  }

  static Color get inside1 {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight 
          ? Colors.black.withOpacity(0.05)
          : Colors.white.withOpacity(0.1);
    } catch (e) {
      return Colors.white.withOpacity(0.1);
    }
  }

  static Color get inside2 {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight 
          ? Colors.black.withOpacity(0.08)
          : Colors.white.withOpacity(0.15);
    } catch (e) {
      return Colors.white.withOpacity(0.15);
    }
  }

  static Color get inside3 {
    try {
      final themeController = Get.find<ThemeController>();
      final isLight = themeController.currentTheme == AppTheme.glassLight || 
                      themeController.currentTheme == AppTheme.classicLight;
      return isLight 
          ? Colors.black.withOpacity(0.1)
          : Colors.white.withOpacity(0.2);
    } catch (e) {
      return Colors.white.withOpacity(0.2);
    }
  }
}
