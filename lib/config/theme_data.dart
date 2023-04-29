import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyTheme {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  final _key1 = 'isSystemMode';

  ThemeMode get themeMode => _loadThemeFromBox()
      ? ThemeMode.dark
      : _loadSystemTheme()
          ? ThemeMode.system
          : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  bool _loadSystemTheme() => _box.read(_key1) ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  _saveThemeSystem(bool isSystem) => _box.write(_key1, isSystem);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());

    // //set haptic feedback
    // if (themeMode == ThemeMode.dark) {
    //   Haptic.feedbackClick();
    // } else {
    //   Haptic.feedbackSuccess();
    // }
  }

  Future<void> switchThemeDialog() async {
    await Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AlertDialog(
          icon: const Icon(Icons.format_paint),
          title: Text('Tema'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.lightbulb,
                  color: Get.isDarkMode == false && _loadSystemTheme() == false
                      ? Get.theme.colorScheme.primary
                      : Get.theme.iconTheme.color,
                ),
                title: Text(
                  'Cerah'.tr,
                  style: TextStyle(
                    color:
                        Get.isDarkMode == false && _loadSystemTheme() == false
                            ? Get.theme.colorScheme.primary
                            : Get.theme.iconTheme.color,
                  ),
                ),
                onTap: () async {
                  _saveThemeSystem(false);
                  _saveThemeToBox(false);
                  Get.changeThemeMode(ThemeMode.light);
                  await Future.delayed(const Duration(milliseconds: 300));
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.dark_mode,
                  color: Get.isDarkMode && _loadSystemTheme() == false
                      ? Get.theme.colorScheme.primary
                      : Get.theme.iconTheme.color,
                ),
                title: Text(
                  'Gelap'.tr,
                  style: TextStyle(
                    color: Get.isDarkMode && _loadSystemTheme() == false
                        ? Get.theme.colorScheme.primary
                        : Get.theme.iconTheme.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  _saveThemeSystem(false);
                  _saveThemeToBox(true);
                  Get.changeThemeMode(ThemeMode.dark);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_suggest,
                  color: _loadSystemTheme() == true
                      ? Get.theme.colorScheme.primary
                      : Get.theme.iconTheme.color,
                ),
                title: Text(
                  'Sistem'.tr,
                  style: TextStyle(
                    color: _loadSystemTheme() == true
                        ? Get.theme.colorScheme.primary
                        : Get.theme.iconTheme.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  _saveThemeSystem(true);
                  Get.changeThemeMode(ThemeMode.system);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setDarkMode() {
    Get.changeThemeMode(ThemeMode.dark);
    _saveThemeToBox(true);
    _saveThemeSystem(false);
  }

  void setLightMode() {
    Get.changeThemeMode(ThemeMode.light);
    _saveThemeToBox(false);
    _saveThemeSystem(false);
  }

  void setSystemMode() {
    Get.changeThemeMode(ThemeMode.system);
    _saveThemeToBox(false);
    _saveThemeSystem(true);
  }

  ThemeData? lightTheme(ColorScheme color) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: color,
      scaffoldBackgroundColor: color.background,
      appBarTheme: AppBarTheme(
        backgroundColor: color.background,
        toolbarHeight: 80,
        shadowColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: color.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: color.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: color.error,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: color.error,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(color.surface),
          backgroundColor: MaterialStateProperty.all<Color>(color.primary),
          shadowColor: MaterialStateProperty.all<Color>(color.primary),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
          elevation: MaterialStateProperty.all<double>(7),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  ThemeData? darkTheme(ColorScheme color) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: color.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: color.surface,
        toolbarHeight: 80,
      ),
      brightness: Brightness.dark,
      colorScheme: color,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade800),
        filled: true,
        fillColor: Colors.grey.shade900,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: color.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: color.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: color.error,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: color.error,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(color.surface),
          backgroundColor: MaterialStateProperty.all<Color>(color.primary),
          shadowColor: MaterialStateProperty.all<Color>(color.primary),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
          elevation: MaterialStateProperty.all<double>(7),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
