import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { glass, light, dark }

class ThemeController extends GetxController {
  final _currentTheme = AppTheme.glass.obs;
  AppTheme get currentTheme => _currentTheme.value;

  static const String _themeKey = 'app_theme';

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString != null) {
      _currentTheme.value = AppTheme.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => AppTheme.glass,
      );
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme.value = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.toString());

    // Update Global Theme if needed
    _updateGlobalTheme();
  }

  void _updateGlobalTheme() {
    switch (_currentTheme.value) {
      case AppTheme.light:
        Get.changeTheme(ThemeData.light());
        break;
      case AppTheme.dark:
        Get.changeTheme(ThemeData.dark());
        break;
      case AppTheme.glass:
        // Glass uses a custom look, we can keep the base dark or light
        // For now, let's stick to a dark base for glass
        Get.changeTheme(ThemeData.dark());
        break;
    }
  }
}
