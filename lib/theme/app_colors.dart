import 'package:flutter/material.dart';

class AppColors {
  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    // primary
    primary: primary,
    onPrimary: white,
    primaryContainer: primaryLight,
    onPrimaryContainer: textColor,
    secondary: Colors.transparent,
    onSecondary: Colors.transparent,
    // background
    surface: white,
    onSurface: textColor,
    // errors
    error: error,
    onError: white,
    errorContainer: errorLight,
    onErrorContainer: error,
  );

  static const primary = Colors.black;
  static const primaryLight = Colors.grey;
  static const textColor = Color(0xFF212121);
  static const error = Color(0xFFD32F2F);
  static const errorLight = Color(0xFFFCDFDF);
  static const success = Color(0xFF198754);
  static const white = Color(0xFFFFFFFF);
}
