import 'package:flutter/material.dart';

enum Sizes {
  s120(120),
  s100(100),
  s64(64),
  s32(32),
  s24(24),
  s16(16),
  s12(12),
  s10(10),
  s6(6),
  s0(0),
  ;

  final double value;

  const Sizes(this.value);

  // paddings:

  EdgeInsets get padX => EdgeInsets.symmetric(horizontal: value);

  EdgeInsets get padY => EdgeInsets.symmetric(vertical: value);

  EdgeInsets get pad => EdgeInsets.all(value);

  static EdgeInsets padXY({required Sizes x, required Sizes y}) {
    return EdgeInsets.symmetric(
      horizontal: x.value,
      vertical: y.value,
    );
  }

  // spaces:

  SizedBox get spaceX => SizedBox(width: value);

  SizedBox get spaceY => SizedBox(height: value);

  SizedBox get space => SizedBox(width: value, height: value);

  static SizedBox spaceXY({required Sizes x, required Sizes y}) {
    return SizedBox(
      width: x.value,
      height: y.value,
    );
  }
}
