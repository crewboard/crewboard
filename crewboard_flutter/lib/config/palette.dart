import 'dart:async';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../controllers/theme_controller.dart';
import '../widgets/document/src/editor_toolbar_shared/color.dart';

StreamController<String> refresh = StreamController<String>.broadcast();
StreamSink<String> get refreshSink => refresh.sink;
Stream<String> get refreshStream => refresh.stream;

StreamController<String> request = StreamController<String>.broadcast();
StreamSink<String> get requestSink => request.sink;
Stream<String> get requestStream => request.stream;

StreamController<String> message = StreamController<String>.broadcast();
StreamSink<String> get messageSink => message.sink;
Stream<String> get messageStream => message.stream;

enum CurrentPage { chat, documentation, planner, settings }

class Window {
  static double width = 0;
  static double height = 0;
  static double sideBarWidth = 280;
  static bool active = true;
}

class Pallet {
  static AppTheme _currentTheme = AppTheme.glassDark;

  static void setTheme(AppTheme theme) {
    _currentTheme = theme;
  }

  static Color theme = Colors.black;
  static const Color background = Color(0xFFFAFAFA);
  static const Color insideFont = Color(0xFF1F2937);

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0C3748), Color(0xFF15212A)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static bool get _isLight =>
      _currentTheme == AppTheme.glassLight ||
      _currentTheme == AppTheme.classicLight;

  // Dynamic colors based on theme
  static Color get divider {
    return const Color(0xFF728b99).withOpacity(0.3);
  }

  static Color get font1 {
    return _isLight ? const Color(0xFF1F2937) : const Color(0xFFe6e8ed);
  }

  static Color get font2 {
    return _isLight ? const Color(0xFF4B5563) : const Color(0xFFc9ccd3);
  }

  static Color get font3 {
    return _isLight ? const Color(0xFF6B7280) : const Color(0xFF728b99);
  }

  static Color get inside1 {
    return _isLight
        ? Colors.black.withOpacity(0.05)
        : Colors.white.withOpacity(0.1);
  }

  static Color get inside2 {
    return _isLight
        ? Colors.black.withOpacity(0.08)
        : Colors.white.withOpacity(0.15);
  }

  static Color get inside3 {
    return _isLight
        ? Colors.black.withOpacity(0.1)
        : Colors.white.withOpacity(0.2);
  }

  static WindowButtonColors get windowButtonColors {
    // Use theme colors
    final iconColor = _isLight
        ? const Color(0xFF1F2937)
        : const Color(0xFFe6e8ed);
    final hoverColor = _isLight
        ? Colors.black.withOpacity(0.1)
        : Colors.white.withOpacity(0.1);
    final mouseDownColor = _isLight
        ? Colors.black.withOpacity(0.2)
        : Colors.white.withOpacity(0.2);

    return WindowButtonColors(
      iconNormal: iconColor,
      mouseOver: hoverColor,
      mouseDown: mouseDownColor,
      iconMouseOver: iconColor,
      iconMouseDown: iconColor,
    );
  }

  static WindowButtonColors get closeWindowButtonColors {
    return WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: windowButtonColors.iconNormal,
      iconMouseOver: Colors.white,
    );
  }

  static Color getUserColor(User user) {
    if (user.color != null) {
      return hexToColor(user.color!.color);
    }
    return Colors.blue;
  }

  static Color getRoomColor(ChatRoom room, UuidValue? currentUserId) {
    if (room.roomType == 'direct' &&
        room.roomUsers != null &&
        currentUserId != null) {
      final otherUser = room.roomUsers!.firstWhereOrNull(
        (u) => u.id != currentUserId,
      );
      if (otherUser != null) {
        return getUserColor(otherUser);
      }
    }
    return Colors.blue;
  }
}
