import 'package:flutter/material.dart';

import '../../../theme/sizes.dart';
import '../entities/card_data.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.width,
    required this.color,
    required this.darkColor,
    required this.textColor,
    required this.data,
  });

  final double width;
  final Color color;
  final Color darkColor;
  final Color textColor;
  final CardData data;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      height: 2,
      letterSpacing: 3,
      wordSpacing: 5,
      fontWeight: FontWeight.w500,
      color: textColor,
    );

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      data.holderName.toUpperCase(),
                      style: textStyle,
                    ),
                    Text(
                      data.expirtyDate.toUpperCase(),
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              Text(
                data.applicationName,
                textAlign: TextAlign.right,
                style: textStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              data.cardNumber,
              maxLines: 1,
              style: TextStyle(
                letterSpacing: 5,
                wordSpacing: 12,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
