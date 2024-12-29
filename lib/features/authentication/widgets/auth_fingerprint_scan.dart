import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/theme_ext.dart';
import '../../../theme/app_colors.dart';
import '../controllers/auth_notifier.dart';
import 'fingerprint_scan.dart';

class AuthFingerprintScan extends ConsumerStatefulWidget {
  const AuthFingerprintScan({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthFingerprintScanState();
}

class _AuthFingerprintScanState extends ConsumerState<AuthFingerprintScan> {
  @override
  Widget build(BuildContext context) {
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

  @override
  void initState() {
    super.initState();
    startAuthentication();
  }

  void startAuthentication() async {
    await Future.delayed(Duration.zero);
    ref.read(authNotifier.notifier).authenticate();
  }
}
