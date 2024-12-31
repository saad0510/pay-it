import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmTokenProvider = StreamProvider.autoDispose<String>(
  (ref) async* {
    yield await FirebaseMessaging.instance.getToken() ?? '';
    yield* FirebaseMessaging.instance.onTokenRefresh;
  },
);
