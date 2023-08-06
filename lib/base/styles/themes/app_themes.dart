//https://api.flutter.dev/flutter/material/TextTheme-class.html
import 'package:flutter/material.dart';

import '../../../data/local_repositories/local_repository.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class AppThemes {
  static final AppThemes instance = AppThemes._internal();
  AppThemes._internal() {
    // initialization logic
  }

  ThemeMode themeMode = ThemeMode.dark;
  ThemeData light = appLightTheme;
  ThemeData dark = appDarkTheme;
  Future<ThemeMode> loadTheme() async {
    themeMode = await LocalRepository().themes();
    return themeMode;
  }

  Future<void> switchTheme() async {
    // Call this function to switch ThemeMode
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    await LocalRepository().saveTheme(themeMode);
    // Get.changeThemeMode(themeMode);
  }
}
