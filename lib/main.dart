import 'dart:developer' show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_constants.dart';
import 'features/authentication/controllers/auth_notifier.dart';
import 'features/authentication/screens/authentication_screen.dart';
import 'features/notifications/controllers/fcm_provider.dart';
import 'features/notifications/controllers/notification_notifier.dart';
import 'features/payments/screens/card_scan_screen.dart';
import 'features/payments/screens/transaction_screen.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: AppTheme().theme,
        home: Consumer(
          builder: (_, ref, __) {
            final screen = ref.watch(currentScreenProvider).valueOrNull;
            return screen ?? const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

final currentScreenProvider = FutureProvider<Widget>(
  (ref) async {
    final auth = ref.watch(authNotifier).unwrapPrevious().valueOrNull ?? false;
    if (!auth) return const AuthenticationScreen();
    await Future.delayed(const Duration(seconds: 1));

    ref.listen(
      fcmTokenProvider,
      (_, fcm) {
        log(fcm.valueOrNull?.toString() ?? '', name: 'fcm');
      },
    );

    final notification = ref.watch(notificationNotifier);
    if (notification != null) {
      log(notification.toMap().toString(), name: 'notification');
      return const TransactionScreen();
    }

    return const CardScanScreen();
  },
);
