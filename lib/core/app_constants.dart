import 'package:flutter/material.dart';
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/user_model.dart';

class AppConstants {
  static int? temExamIdMCQ;

  static String appTitle = 'Samastha';

  static String isParentLogedIn = 'isParent-logedin-local-storage';
  static String studenIdLocalName = 'Student-Id-local-storage';

  static LoginResponse? loggedUser;

  static UserModel? tempRegisterModel;

  static int? studentID;

  static int? tempSelected;

  //hive keys
  static const String hiveStorageKey = 'local_video_dowload';
  static const String getStorageKey = 'local_video_storage_key';

//shared prefs keys
  static const String userKey = 'user';
  static const String introKey = 'intro';
  static String tokenKey = 'token';

  static Map<String, dynamic> userAgent = {};

  static const String rupeeSign = '₹';
  static const String defaultDialCode = '91';

  static final globalNavigatorKey = GlobalKey<NavigatorState>();
  static final coursesNavigatorKey = GlobalKey<NavigatorState>();
  static final summaryNavigatorKey = GlobalKey<NavigatorState>();
  static final homeNavigatorKey = GlobalKey<NavigatorState>();
  static final notificationNavigatorKey = GlobalKey<NavigatorState>();
  static final profileNavigatorKey = GlobalKey<NavigatorState>();

  static final kidsHomeNavigatorKey = GlobalKey<NavigatorState>();
  static final kidsNotificationNavigatorKey = GlobalKey<NavigatorState>();
  static final kidsProfileNavigatorKey = GlobalKey<NavigatorState>();

  static String lorem =
      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.''';

  static String? fcmToken;

  static String currentPlayingAudioUrl = '';
}
