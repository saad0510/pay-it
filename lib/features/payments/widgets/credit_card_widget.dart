import 'package:flutter/material.dart';

import '../../../theme/sizes.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.width,
    required this.color,
    required this.darkColor,
    required this.textColor,
  });

  final double width;
  final Color color;
  final Color darkColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width / 1.5,
      padding: Sizes.padXY(x: Sizes.s32, y: Sizes.s24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 0.9, 1],
          colors: [darkColor, color, darkColor],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'VISA\nPLATINUM',
            style: TextStyle(
              fontSize: 12,
              height: 2,
              letterSpacing: 3,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const Spacer(),
          Text(
            '**** **** **** 5610',
            maxLines: 1,
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 5,
              wordSpacing: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
