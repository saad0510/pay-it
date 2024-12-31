import 'package:flutter/material.dart';

import '../../../core/assets/app_images.dart';

class MastercardIcon extends StatelessWidget {
  const MastercardIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.black87,
      child: Image.asset(
        AppImages.mastercard.path,
        width: 25,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
