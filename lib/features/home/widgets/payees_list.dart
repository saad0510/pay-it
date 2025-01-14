import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../entities/user_data.dart';
import 'new_payee_button.dart';
import 'user_avatar.dart';

class PayeesList extends StatelessWidget {
  const PayeesList({super.key});

  @override
  Widget build(BuildContext context) {
    const users = UserData.randomUsers;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimateList(
          delay: const Duration(milliseconds: 100),
          interval: const Duration(milliseconds: 100),
          effects: [const FadeEffect()],
          children: [
            const NewPayeeButton(),
            const SizedBox(width: 20),
            for (final user in users) //
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: UserAvatar(user: user),
              ),
          ],
        ),
      ),
    );
  }
}
