import 'package:flutter/material.dart';

import '../../../theme/sizes.dart';

class AndroidPhoneAnimation extends StatefulWidget {
  const AndroidPhoneAnimation({super.key});

  @override
  State<AndroidPhoneAnimation> createState() => _AndroidPhoneAnimationState();
}

class _AndroidPhoneAnimationState extends State<AndroidPhoneAnimation> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final animation = Tween<double>(begin: -0.4, end: 0.2).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateX(animation.value),
          child: child,
        );
      },
      child: Container(
        width: deviceSize.width * 0.6,
        height: deviceSize.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 0.9, 1],
            colors: [
              Colors.black,
              Colors.grey.shade900,
              Colors.black,
            ],
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: Sizes.s16.pad,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.9, 1],
              colors: [
                Colors.white,
                Colors.grey.shade300,
              ],
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: Sizes.padXY(x: Sizes.s64, y: Sizes.s10),
            height: Sizes.s10.value,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
