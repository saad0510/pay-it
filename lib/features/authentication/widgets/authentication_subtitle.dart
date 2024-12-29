import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_screen.dart';
import '../../../core/extensions/theme_ext.dart';
import '../../../theme/sizes.dart';
import '../controllers/auth_notifier.dart';

class AuthenticationSubtitle extends ConsumerWidget {
  const AuthenticationSubtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifier);

    Widget widget = const Text(
      'You need to authenticate yourself before proceeding any further',
      textAlign: TextAlign.center,
    );

    if (auth.value ?? false)
      widget = const Text(
        'Redirecting',
        textAlign: TextAlign.center,
      );

    if (auth.hasError)
      widget = InkWell(
        onTap: () {
          final error = ErrorScreen(
            title: 'Authentication Failed',
            error: auth.error,
            stackTrace: auth.stackTrace,
          );
          error.showSheet(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                auth.error is String ? auth.error.toString() : 'Error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colors.error,
                ),
              ),
            ),
            Sizes.s6.spaceX,
            Icon(
              Icons.arrow_upward,
              size: Sizes.s16.value,
              color: context.colors.error,
            ),
          ],
        ),
      );

    final key = auth.when(
      skipLoadingOnReload: true,
      data: (x) => ValueKey(x),
      error: (_, __) => const Key('error'),
      loading: () => const Key('loading'),
    );

    return Animate(
      key: key,
      effects: const [FadeEffect(), MoveEffect()],
      child: widget,
    );
  }
}
