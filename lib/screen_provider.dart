import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_friendly_name/device_friendly_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/extensions/json_ext.dart';
import 'features/authentication/controllers/auth_notifier.dart';
import 'features/authentication/screens/authentication_screen.dart';
import 'features/notifications/controllers/fcm_provider.dart';
import 'features/notifications/controllers/notification_notifier.dart';
import 'features/payments/screens/card_scan_screen.dart';
import 'features/payments/screens/transaction_screen.dart';

final currentScreenProvider = FutureProvider<Widget>(
  (ref) async {
    final auth = ref.watch(authNotifier).unwrapPrevious().valueOrNull ?? false;
    if (!auth) return const AuthenticationScreen();
    await Future.delayed(const Duration(seconds: 1));

    ref.listen(
      fcmTokenProvider,
      (prev, next) => onFcmChanged(prev?.valueOrNull, next.valueOrNull),
    );

    final notification = ref.watch(notificationNotifier);
    if (notification != null) {
      final id = decodeTransactionId(notification);
      if (id != null) return TransactionScreen(transactionID: id);
    }

    return const CardScanScreen();
  },
);

void onFcmChanged(String? oldFcm, String? newFcm) async {
  if (oldFcm == newFcm) return;

  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) return;

  final data = {
    'fcm': newFcm,
    'device_name': await DeviceFriendlyName().getDeviceFriendlyName(),
    'updated_at': DateTime.now().toFirebaseTimestamp(),
  };
  final users = FirebaseFirestore.instance.collection('users');
  await users.doc(userId).set(data, SetOptions(merge: true));
}

String? decodeTransactionId(RemoteMessage notification) {
  final transactionId = notification.data.decodeStr('transaction_id').trim();
  return transactionId.isEmpty ? null : transactionId;
}
