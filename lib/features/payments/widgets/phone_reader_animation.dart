import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/assets/app_animations.dart';

class PhoneReaderAnimation extends StatelessWidget {
  const PhoneReaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAnimations.nfc_reading.path,
      key: const Key('reader_animation'),
      width: 200,
      height: 200,
      frameRate: FrameRate.max,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.strokeColor(
            ['**'],
            value: Colors.black,
          ),
          ValueDelegate.color(
            ['**', 'phone-shine', '**'],
            value: Colors.grey,
          ),
        ],
      ),
    );
  }
}
