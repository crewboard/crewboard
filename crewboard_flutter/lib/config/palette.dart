import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  static Color background = const Color(0xFFFAFAFA);
  static Color insideFont = const Color(0xFF1F2937);

  static LinearGradient backgroundGradient = const LinearGradient(
    colors: [Color(0xFF0C3748), Color(0xFF15212A)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static Color divider = const Color(0xFF728b99).withOpacity(0.3);
  static Color font1 = const Color(0xFFe6e8ed);
  static Color font2 = const Color(0xFFc9ccd3);
  static Color font3 = const Color(0xFF728b99);

  static Color inside1 = Colors.white.withOpacity(0.1);
  static Color inside2 = Colors.white.withOpacity(0.1);
  static Color inside3 = Colors.white.withOpacity(0.1);
}
