import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../controller/card_scan_notifier.dart';
import '../entities/card_data.dart';
import 'credit_card_widget.dart';

class CreditCardAnimation extends StatefulWidget {
  const CreditCardAnimation({
    super.key,
    required this.extend,
    required this.offset,
  });

  final double extend;
  final double offset;

  @override
  State<CreditCardAnimation> createState() => _CreditCardAnimationState();
}

class _CreditCardAnimationState extends State<CreditCardAnimation> with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: const Key('card_animation'),
      tween: Tween(begin: 0, end: widget.extend),
      duration: const Duration(seconds: 2),
      curve: Curves.elasticInOut,
      onEnd: () => controller.repeat(reverse: true),
      builder: (context, value, child) {
        final displacement = (value * widget.offset / widget.extend);

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(0.0, displacement) //
            ..setEntry(3, 2, 0.002) //
            ..rotateX(-pi * value) //
          ,
          child: child,
        );
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, child) {
          final offset = controller.isAnimating ? controller.value : 0.0;

          return Transform.translate(
            offset: Offset(0, offset),
            child: child!,
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

            final (rotateX, rotateY) = ref.watch(gyroscopeStream).valueOrNull ?? (0.0, 0.0);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
              transformAlignment: Alignment.center,
              transform: Matrix4.identity() //
                ..rotateX(rotateX)
                ..rotateY(rotateY) //
                ..rotateZ(pi / 2) //
              ,
              child: CreditCardWidget(
                width: MediaQuery.sizeOf(context).width * 0.9,
                color: Colors.grey.shade900,
                darkColor: Colors.black,
                textColor: Colors.white,
                data: card ?? defaultCard,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: 0,
      lowerBound: -5,
      upperBound: 5,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

final gyroscopeStream = StreamProvider.autoDispose<(double, double)>(
  (ref) async* {
    var prevVal = (0.0, 0.0);

    await for (final event in gyroscopeEventStream(samplingPeriod: const Duration(milliseconds: 200))) {
      var rotateX = (event.x / 15).clamp(-0.3, 0.3);
      var rotateY = (event.y / 15).clamp(-0.3, 0.3);

      rotateX = rotateX == 0 ? 0.0 : double.parse(rotateX.toStringAsFixed(3));
      rotateY = rotateY == 0 ? 0.0 : double.parse(rotateY.toStringAsFixed(3));

      final newVal = (rotateX, rotateY);
      if (newVal != prevVal) {
        prevVal = newVal;
        yield newVal;
      }
    }
  },
);
