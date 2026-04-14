import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/palette.dart';

enum AppTheme { glassDark, glassLight, classicLight, classicDark }

final themeProvider = AsyncNotifierProvider<ThemeNotifier, AppTheme>(
  ThemeNotifier.new,
);

class ThemeNotifier extends AsyncNotifier<AppTheme> {
  static const String _themeKey = 'app_theme';

  @override
  FutureOr<AppTheme> build() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    final theme = themeString != null
        ? AppTheme.values.firstWhere(
            (e) => e.toString() == themeString,
            orElse: () => AppTheme.glassDark,
          )
        : AppTheme.glassDark;

    // Sync static Pallet
    Pallet.setTheme(theme);
    return theme;
  }

  Future<void> setTheme(AppTheme theme) async {
    state = AsyncData(theme);
    Pallet.setTheme(theme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.toString());
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
