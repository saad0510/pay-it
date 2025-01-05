import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFonts {
  static const fontFamily = 'Ubuntu';

  static const heading1 = TextStyle(
    fontSize: 28,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const heading2 = TextStyle(
    fontSize: 26,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const heading3 = TextStyle(
    fontSize: 24,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const heading4 = TextStyle(
    fontSize: 22,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const heading5 = TextStyle(
    fontSize: 20,
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static const heading6 = TextStyle(
    fontSize: 18,
    height: 1.5,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const paragraph1 = TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const paragraph2 = TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const text1 = TextStyle(
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const text2 = TextStyle(
    fontSize: 10,
    height: 1.5,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const small = TextStyle(
    fontSize: 8,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const tiny = TextStyle(
    fontSize: 6,
    height: 1.5,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static final textTheme = const TextTheme(
    displayLarge: TextStyle(),
    displayMedium: TextStyle(),
    displaySmall: TextStyle(),
    headlineLarge: TextStyle(),
    headlineMedium: TextStyle(),
    headlineSmall: heading4,
    titleLarge: heading6,
    titleMedium: TextStyle(),
    titleSmall: TextStyle(),
    labelLarge: TextStyle(),
    labelMedium: TextStyle(),
    labelSmall: TextStyle(),
    bodyLarge: TextStyle(),
    bodyMedium: paragraph1,
    bodySmall: paragraph2,
  ).apply(
    fontFamily: fontFamily,
    bodyColor: AppColors.textColor,
    displayColor: AppColors.primary,
  );
}
