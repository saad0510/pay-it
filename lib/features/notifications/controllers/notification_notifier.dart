import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends Notifier<RemoteMessage?> {
  StreamSubscription<RemoteMessage>? foregroundInteraction;
  StreamSubscription<RemoteMessage>? backgroundInteraction;

  RemoteMessage? _latestMessage;
  final messaging = FirebaseMessaging.instance;
  final localNotifications = FlutterLocalNotificationsPlugin();

  @override
  RemoteMessage? build() {
    initController();
    ref.onDispose(dispose);
    return null;
  }

  void initController() async {
    await messaging.requestPermission();
    await messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    await localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (details) => _latestMessage != null ? handleInteraction(_latestMessage!) : null,
    );
    await localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    startListening();
  }

  void startListening() {
    _handleForegroundInteraction();
    _handleBackgroundInteraction();
    setupForegroundNotification();
    setupBackgroundNotification();
  }

  void handleInteraction(RemoteMessage message) {
    state = message;
  }

  void handleNotification(RemoteMessage message) async {}

  void _handleForegroundInteraction() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage == null) return;
    handleInteraction(initialMessage);
  }

  void _handleBackgroundInteraction() {
    backgroundInteraction?.cancel();
    backgroundInteraction = FirebaseMessaging.onMessageOpenedApp.listen((_) {});
    backgroundInteraction?.onData(handleInteraction);
  }

  void setupBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(catchBackgroundNotifications);
  }

  void setupForegroundNotification() {
    foregroundInteraction?.cancel();
    foregroundInteraction = FirebaseMessaging.onMessage.listen((_) {});
    foregroundInteraction?.onData(catchForegroundNotifications);
  }

  void catchForegroundNotifications(RemoteMessage message) async {
    _latestMessage = message;

    final notification = message.notification;
    if (notification == null) return;

    handleNotification(message);
    localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      _notificationDetails,
    );
  }

  void dispose() {
    foregroundInteraction?.cancel();
    backgroundInteraction?.cancel();
  }
}

@pragma('vm:entry-point')
Future<void> catchBackgroundNotifications(RemoteMessage message) async {}

final notificationNotifier = NotifierProvider<NotificationNotifier, RemoteMessage?>(NotificationNotifier.new);

const _channel = AndroidNotificationChannel(
  'payit_channel',
  'PayIt Notifications',
  description: 'This channel is used for foreground notifications of PayIt App.',
  importance: Importance.max,
);

final _notificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    _channel.id,
    _channel.name,
    channelDescription: _channel.description,
    icon: "@mipmap/ic_launcher",
  ),
);
