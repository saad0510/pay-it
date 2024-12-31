import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/card_scan_notifier.dart';
import '../entities/card_data.dart';
import 'credit_card_widget.dart';

class CreditCardAnimation extends StatelessWidget {
  const CreditCardAnimation({
    super.key,
    required this.extend,
    required this.offset,
  });

  final double extend;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: const Key('card_animation'),
      tween: Tween(begin: 0, end: extend),
      duration: const Duration(seconds: 2),
      curve: Curves.elasticInOut,
      builder: (context, value, child) {
        final displacement = (value * offset / extend);

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(0.0, displacement) //
            ..setEntry(3, 2, 0.002) //
            ..rotateX(-pi * value) //
            ..rotateZ(pi / 2) //
          ,
          child: child,
        );
      },
      child: Consumer(
        builder: (context, ref, _) {
          final card = ref.watch(cardScanNotifier).value;
          const defaultCard = CardData(
            holderName: 'HOLDER NAME',
            cardNumber: '**** **** **** 5610',
            applicationName: '',
            expirtyDate: '00/00',
          );

          return CreditCardWidget(
            width: MediaQuery.sizeOf(context).width * 0.9,
            color: Colors.grey.shade900,
            darkColor: Colors.black,
            textColor: Colors.white,
            data: card ?? defaultCard,
          );
        },
      ),
    );
  }
}
