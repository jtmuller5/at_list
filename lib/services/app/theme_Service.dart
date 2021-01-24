import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_themes/stacked_themes.dart';

@injectable
class ThemeService {
  void setLightMode(BuildContext context) {
    getThemeManager(context).setThemeMode(ThemeMode.light);
  }

  void setDarkMode(BuildContext context) {
    getThemeManager(context).setThemeMode(ThemeMode.dark);
  }

  void toggleLightDarkMode(BuildContext context) {
    getThemeManager(context).toggleDarkLightTheme();
  }
}