import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/extensions/theme_ext.dart';
import 'app_buttons_styles.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'sizes.dart';

class AppTheme {
  const AppTheme._();

  static final theme = ThemeData(
    colorScheme: AppColors.colorScheme,
    textTheme: AppFonts.textTheme,
    iconTheme: iconTheme,
    inputDecorationTheme: inputFieldTheme,
    appBarTheme: appBarTheme,
    iconButtonTheme: const IconButtonThemeData(
      style: AppButtonsStyles.iconButton,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonsStyles.elevatedButton,
    ),
    textButtonTheme: TextButtonThemeData(
      style: AppButtonsStyles.textButton,
    ),
  );

  static const appBarTheme = AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.primary,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: lightOverlay,
  );

  static const lightOverlay = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: AppColors.white,
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static const darkOverlay = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.primary,
    systemNavigationBarColor: AppColors.primary,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static const iconTheme = IconThemeData(
    color: AppColors.primary,
  );

  static final inputFieldTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF1F1F1),
    alignLabelWithHint: true,
    contentPadding: Sizes.s16.pad,
    hintStyle: AppFonts.paragraph1.colored(AppColors.textColor),
    labelStyle: AppFonts.paragraph1.colored(AppColors.textColor),
    border: inputFieldBorder(),
    enabledBorder: inputFieldBorder(),
    disabledBorder: inputFieldBorder(),
    focusedBorder: inputFieldBorder(color: AppColors.primary),
    errorBorder: inputFieldBorder(color: AppColors.error),
    focusedErrorBorder: inputFieldBorder(color: AppColors.error),
  );

  static InputBorder inputFieldBorder({Color? color}) {
    if (color != null)
      return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      );

    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
  }
}
