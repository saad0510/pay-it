import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/credit_card_animation.dart';
import '../widgets/phone_reader_animation.dart';

class CardScanScreen extends StatelessWidget {
  const CardScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Scan'),
      ),
      body: const Center(
        child: CreditCardAnimation(
          extend: 0.1,
          offset: -150,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        children: [
          Animate(
            delay: const Duration(milliseconds: 1500),
            effects: const [ShakeEffect(), FadeEffect()],
            child: const Text(
              'HOLD NEAR READER',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 2,
                wordSpacing: 5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const PhoneReaderAnimation(),
        ],
      ),
    );
  }
}
