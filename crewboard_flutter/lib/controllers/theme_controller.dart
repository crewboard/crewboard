import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { glassDark, glassLight, classicLight, classicDark }

class ThemeController extends GetxController {
  final _currentTheme = AppTheme.glassDark.obs;
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
        orElse: () => AppTheme.glassDark,
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
      case AppTheme.classicLight:
        Get.changeTheme(ThemeData.light());
        break;
      case AppTheme.classicDark:
        Get.changeTheme(ThemeData.dark());
        break;
      case AppTheme.glassDark:
        Get.changeTheme(ThemeData.dark());
        break;
      case AppTheme.glassLight:
        Get.changeTheme(ThemeData.light());
        break;
    }
  }
  
  String getThemeName(AppTheme theme) {
    switch (theme) {
      case AppTheme.glassDark:
        return 'Glass Dark';
      case AppTheme.glassLight:
        return 'Glass Light';
      case AppTheme.classicLight:
        return 'Classic Light';
      case AppTheme.classicDark:
        return 'Classic Dark';
    }
  }
}
