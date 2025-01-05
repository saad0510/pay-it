import 'package:flutter/material.dart';

import '../../../core/extensions/theme_ext.dart';
import '../entities/user_data.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: context.typography.bodySmall.colored(context.colors.onPrimary),
          ),
        ],
      ),
    );
  }
}
