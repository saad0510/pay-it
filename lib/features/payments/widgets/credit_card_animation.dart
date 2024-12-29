import 'dart:math';

import 'package:flutter/material.dart';

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
      child: CreditCardWidget(
        width: MediaQuery.sizeOf(context).width * 0.9,
        color: Colors.grey.shade900,
        darkColor: Colors.black,
        textColor: Colors.white,
      ),
    );
  }
}
