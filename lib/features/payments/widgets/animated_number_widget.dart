import 'package:flutter/material.dart';

class AnimatedNumberWidget extends StatefulWidget {
  final double number;
  final Widget Function(BuildContext context, double value) builder;

  const AnimatedNumberWidget({
    super.key,
    required this.number,
    required this.builder,
  });

  @override
  State<AnimatedNumberWidget> createState() => _AnimatedNumberWidgetState();
}

class _AnimatedNumberWidgetState extends State<AnimatedNumberWidget> {
  double oldNumber = 0;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.number == oldWidget.number) return;
    oldNumber = oldWidget.number;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey(widget.number),
      tween: Tween<double>(begin: oldNumber, end: widget.number),
      duration: const Duration(seconds: 1),
      curve: Curves.decelerate,
      builder: (context, value, _) => widget.builder(context, value),
    );
  }
}
