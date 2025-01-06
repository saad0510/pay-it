import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/app_constants.dart';
import '../../../core/assets/app_icons.dart';
import '../../../core/extensions/theme_ext.dart';
import '../../../theme/sizes.dart';
import '../../payments/widgets/animated_number_widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: Sizes.padXY(x: Sizes.s24, y: Sizes.s12),
      leading: const CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(AppConstants.userProfilePic),
      ),
      title: Text(
        'Total Balance',
        style: context.typography.bodySmall,
      ),
      subtitle: AnimatedNumberWidget(
        number: 75102,
        builder: (_, x) => Text(
          '\$${x.toStringAsFixed(2)}',
          style: context.typography.titleLarge,
        ),
      ),
      trailing: Animate(
        effects: const [ShakeEffect()],
        delay: const Duration(seconds: 3),
        child: AppNetworkIcons.notification.toImage(),
      ),
    );
  }
}
