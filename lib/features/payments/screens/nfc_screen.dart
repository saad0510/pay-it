import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../theme/sizes.dart';
import '../widgets/android_phone_animation.dart';

class NfcScreen extends StatelessWidget {
  const NfcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Scan'),
      ),
      body: const Center(
        child: AndroidPhoneAnimation(),
      ),
      bottomNavigationBar: Padding(
        padding: Sizes.s32.pad,
        key: UniqueKey(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Animate(
              effects: const [ShakeEffect()],
              child: const Text(
                'HOLD NEAR NFC CARD',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 3,
                  height: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Animate(
              effects: const [FadeEffect(), MoveEffect()],
              child: const Text(
                'Waiting for scan',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
