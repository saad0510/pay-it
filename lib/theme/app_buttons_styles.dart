import 'package:flutter/material.dart';

import '../core/extensions/theme_ext.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'sizes.dart';

class AppButtonsStyles {
  static const primaryForeground = AppColors.white;
  static const primaryBackground = AppColors.primary;
  static const primaryOverlay = AppColors.primaryLight;

  static const secondaryForeground = AppColors.primary;
  static const secondaryBackground = AppColors.white;
  static final secondaryOverlay = Colors.grey.shade100;

  static final _textStyle = AppFonts.heading6.copyWith(
    leadingDistribution: TextLeadingDistribution.even,
  );

  // ElevatedButton:

  static ButtonStyle _baseStyles(ButtonStyle buttonStyle) {
    return buttonStyle.copyWith(
      elevation: const _Fixed(0),
      alignment: Alignment.center,
      padding: _Fixed(Sizes.s24.pad),
      textStyle: buttonStyle.textStyle ?? _Fixed(_textStyle),
      visualDensity: VisualDensity.compact,
      shadowColor: const _Fixed(Colors.transparent),
      shape: const _Fixed(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  static final elevatedButton = _baseStyles(
    ElevatedButton.styleFrom(
      backgroundColor: primaryBackground,
      foregroundColor: primaryForeground,
      overlayColor: primaryOverlay,
      textStyle: _textStyle,
    ),
  );

  // TextButton:

  static final textButton = _baseStyles(
    TextButton.styleFrom(
      textStyle: _textStyle.weighted(FontWeight.w500),
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primary,
      overlayColor: primaryOverlay,
    ),
  );

  // IconButton:

  static const iconButton = ButtonStyle(
    elevation: _Fixed(0),
    padding: _Fixed(EdgeInsets.zero),
    visualDensity: VisualDensity.comfortable,
    alignment: Alignment.center,
    iconSize: _Fixed(24),
    fixedSize: _Fixed(Size(35, 35)),
    backgroundColor: _Fixed(secondaryBackground),
    foregroundColor: _Fixed(secondaryForeground),
    shadowColor: _Fixed(Colors.transparent),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: _Fixed(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}

typedef _Fixed<T> = WidgetStatePropertyAll<T>;
