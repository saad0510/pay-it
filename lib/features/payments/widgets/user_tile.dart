import 'package:flutter/material.dart';

import '../../../core/extensions/theme_ext.dart';
import '../../../theme/sizes.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.name,
    required this.phone,
  });

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        contentPadding: Sizes.padXY(x: Sizes.s16, y: Sizes.s3),
        leading: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=12'),
        ),
        title: Text(name),
        subtitle: Text(phone),
        titleTextStyle: context.typography.titleMedium,
        trailing: const Icon(
          Icons.phone,
          size: 24,
          color: Colors.black54,
        ),
      ),
    );
  }
}
