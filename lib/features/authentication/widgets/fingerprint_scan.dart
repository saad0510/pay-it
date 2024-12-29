import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/assets/app_animations.dart';

class FingerprintScan extends StatefulWidget {
  const FingerprintScan({
    super.key,
    required this.color,
    this.filled = false,
  });

  final Color color;
  final bool filled;

  @override
  State<FingerprintScan> createState() => _FingerprintScanState();
}

class _FingerprintScanState extends State<FingerprintScan> with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAnimations.fingerprint.path,
      key: const ValueKey('fingerprint'),
      width: 500,
      height: 500,
      controller: controller,
      frameRate: FrameRate.max,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.strokeColor(
            ['**'],
            value: widget.color,
          ),
          ValueDelegate.strokeColor(
            ['BG', '**'],
            value: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  void animate() {
    if (widget.filled) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 0.4,
    );
    super.initState();
    Future.microtask(animate);
  }

  @override
  void didUpdateWidget(old) {
    super.didUpdateWidget(old);
    if (old.filled != widget.filled) animate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
