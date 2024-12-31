import 'package:flutter/material.dart';

import '../../../core/extensions/theme_ext.dart';
import '../../../theme/sizes.dart';
import 'mastercard_icon.dart';

class MastercardPreview extends StatelessWidget {
  const MastercardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        contentPadding: Sizes.padXY(x: Sizes.s16, y: Sizes.s3),
        leading: const MastercardIcon(),
        title: const Text('Mastercard'),
        subtitle: const Text('Ending in 9876'),
        titleTextStyle: context.typography.titleMedium,
        trailing: const Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
