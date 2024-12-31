import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_friendly_name/device_friendly_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/extensions/json_ext.dart';
import 'features/authentication/controllers/auth_notifier.dart';
import 'features/authentication/screens/authentication_screen.dart';
import 'features/notifications/controllers/fcm_provider.dart';
import 'features/notifications/controllers/notification_notifier.dart';
import 'features/payments/controller/transaction_provider.dart';
import 'features/payments/entities/transaction_data.dart';
import 'features/payments/entities/transaction_status.dart';
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
      onNewNotification(ref);
      return const TransactionScreen();
    }

    return const CardScanScreen();
  },
);

void onNewNotification(Ref ref) {
  ref.read(transactionProvider.notifier).state = TransactionData(
    id: '123',
    amount: 15034,
    receiverName: 'Saad Bin Khalid',
    receiverPhone: '+923133094567',
    message: null,
    status: TransactionStatus.pending,
    userId: '123',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}

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
