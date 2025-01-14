import 'package:flutter/material.dart';

import '../../../core/extensions/theme_ext.dart';

class NewPayeeButton extends StatelessWidget {
  const NewPayeeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Material(
            color: context.colors.onPrimary,
            type: MaterialType.circle,
            child: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Add New',
          textAlign: TextAlign.center,
          style: context.typography.bodySmall.colored(context.colors.onPrimary),
        ),
      ],
    );
  }
}
