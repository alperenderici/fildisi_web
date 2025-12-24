import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final themeMode = ThemeMode.light.obs;

  bool get isDark => themeMode.value == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }

  void toggle() {
    themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
