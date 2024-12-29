import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/theme_ext.dart';
import '../../../theme/app_colors.dart';
import '../controllers/auth_notifier.dart';

class AuthenticationTitle extends ConsumerWidget {
  const AuthenticationTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifier);

    Widget widget = const SizedBox.shrink();

    if (auth.value ?? false)
      widget = InkWell(
        onLongPress: () {
          ref.read(authNotifier.notifier).authenticate();
        },
        child: const Text(
          'Verified',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.success,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

    if (auth.hasError)
      widget = InkWell(
        onTap: () {
          ref.read(authNotifier.notifier).authenticate();
        },
        child: Text(
          'Retry',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.colors.error,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

    final key = auth.when(
      skipLoadingOnReload: true,
      data: (x) => ValueKey(x),
      error: (_, __) => const ValueKey('error'),
      loading: () => const ValueKey('loading'),
    );

    return Animate(
      key: key,
      effects: const [FadeEffect(), ShakeEffect()],
      child: widget,
    );
  }
}
