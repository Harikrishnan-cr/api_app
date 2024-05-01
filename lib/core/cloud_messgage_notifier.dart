import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class CloudMessagingService {
  static CloudMessagingService? _instance;
  final FirebaseMessaging _firebaseMessaging;

  CloudMessagingService._(this._firebaseMessaging) {
    initFirebaseMessageHandlers();
  }

  static void initialize(FirebaseMessaging firebaseMessaging) {
    _instance ??= CloudMessagingService._(firebaseMessaging);
  }

  static CloudMessagingService get instance => _instance!;

  Future<void> initFirebaseMessageHandlers() async {
    final notificationSettings =
        await _firebaseMessaging.getNotificationSettings();

    if ([AuthorizationStatus.denied, AuthorizationStatus.notDetermined]
        .contains(notificationSettings.authorizationStatus)) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    FirebaseMessaging.onBackgroundMessage(onMessageOpenedAppListener);

    // on receiving a message when the app is in foreground
    FirebaseMessaging.onMessage.listen(
      (event) {
        log('fcm meddage recivide ${event.data.toString()}');
      },
    );

    // on user tapping on the message in notification panel received while
    // the app is in the background
    //FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedAppListener);
    // on user tapping on the message in notification panel received while
    // the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  // void _onMessageListener(RemoteMessage message) {
  //   onNotificationTapped(message.data);
  // }

  void checkForFCMInitialMessage() async {
    // get the RemoteMessage in the Message received while the app was in terminated state
    // and the user tapped on it in the notification panel to open the app
    final initialMessage = await _firebaseMessaging.getInitialMessage();

    if (initialMessage?.data != null) {
      onNotificationTapped(initialMessage!.data);
    }
  }

  Future<void> deleteFCMToken() => _firebaseMessaging.deleteToken();
}

@pragma('vm:entry-point')
Future<void> onMessageOpenedAppListener(RemoteMessage message) async {
  onNotificationTapped(message.data);
}

void onNotificationTapped(Map<String, dynamic> data) {
  if (data.containsKey('action')) {
    final action = data['action'];
    if (action == 'ORDER_DETAILED') {}
  }
}
