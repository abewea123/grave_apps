import 'package:flutter/material.dart';

class MyTheme {
  ThemeData lightTheme(ColorScheme color) {
    return ThemeData(
      useMaterial3: true,
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
    );
  }
}
