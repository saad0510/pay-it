import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/theme_ext.dart';
import '../../../theme/app_colors.dart';
import '../controllers/auth_notifier.dart';
import 'fingerprint_scan.dart';

class AuthFingerprintScan extends ConsumerWidget {
  const AuthFingerprintScan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifier);

    final colors = context.colors;
    final color = auth.when(
      skipLoadingOnReload: true,
      data: (x) => x ? AppColors.success : colors.primary,
      error: (_, __) => colors.error,
      loading: () => colors.primary,
    );

    return FingerprintScan(
      color: color,
      filled: !auth.isLoading,
    );
  }
}
