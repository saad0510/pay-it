import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

extension ContextAccessExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get typography => Theme.of(this).textTheme;
}

extension TextColorsExt on TextStyle? {
  TextStyle? get primary => colored(AppColors.primary);

  TextStyle? colored(Color color) => this?.copyWith(color: color);
}

extension TextWeightsExt on TextStyle? {
  TextStyle? weighted(FontWeight fontWeight) => this?.copyWith(fontWeight: fontWeight);
}

extension TypographyExt on TextStyle? {
  TextStyle? get removeFont => this?.copyWith(fontFamily: '');
}
