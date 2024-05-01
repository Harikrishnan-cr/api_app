import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;

class FcmTokenProvider extends ChangeNotifier {
  String? fcmToken;
  final DioClient dioClient = di.sl<DioClient>();
  late StreamSubscription<String> subscription;

  Future<void> init() async {
    fcmToken = await FirebaseMessaging.instance.getToken();

    updateToken();

    subscription = FirebaseMessaging.instance.onTokenRefresh.listen(
      (event) {
        fcmToken = event;
        updateToken();
      },
    );

    log('fcm token is : $fcmToken');
  }

  Future<void> deleteFcmToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  Future<void> updateToken() async {
    await dioClient.post(Urls.updateFcmToken, data: {"token": fcmToken});
  }

  void cancelSubscription() {
    try {
      subscription.cancel();
    } catch (e) {
      //
    }
  }
}
