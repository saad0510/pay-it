import 'package:flutter/material.dart';

import '../widgets/card_scan_actions.dart';
import '../widgets/credit_card_animation.dart';

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
      bottomNavigationBar: const CardScanActions(),
    );
  }
}
