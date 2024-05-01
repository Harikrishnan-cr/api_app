import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/update_fcm.dart';
import 'package:samastha/firebase_options.dart';
import 'package:samastha/helper/service_locator.dart';
import 'package:samastha/modules/courses/controller/video_speed_provider.dart';
import 'package:samastha/modules/dashboard/controller/faq_screen_conroller.dart';
import 'package:samastha/modules/madrasa/controller/live_class_controller.dart';
import 'package:samastha/modules/madrasa/controller/video_download_controller.dart';
import 'package:samastha/modules/madrasa/models/video_download_modal.dart';
import 'package:samastha/modules/parent/bloc/edit_profile_provider.dart';
import 'package:samastha/modules/parent/bloc/rewards_provider.dart';
import 'package:samastha/modules/parent/controller/certificate_controller.dart';
import 'package:samastha/modules/parent/controller/get_local_videos_controller.dart';
import 'package:samastha/modules/parent/controller/user_profile_edit_controller.dart';
import 'package:samastha/modules/student/controller/leader_board_provider.dart';
import 'package:samastha/modules/student/controller/performance_analysis_controller.dart';

import '../main.dart';
import '../modules/general/bloc/core_bloc.dart';

abstract class Env {
  final String domainUrl;
  static late Env instance;

  Env({
    required this.domainUrl,
  }) {
    boot();
  }
  void boot() async {
    instance = this;
    WidgetsFlutterBinding.ensureInitialized();

    // Hive.registerAdapter(StudentModelAdapter());
    // localDownload = await Hive.openBox<VideoDownlaodModelClass>(
    //     AppConstants.hiveStorageKey);
    await CoreBloc().initSharedData();
    await init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => RewardProvider()),
        ChangeNotifierProvider(create: (context) => FaqScreenController()),
        ChangeNotifierProvider(create: (context) => VideoSpeedProvider()),
        ChangeNotifierProvider(create: (context) => FcmTokenProvider()),
        ChangeNotifierProvider(create: (context) => VideoDownloadController()),
        ChangeNotifierProvider(create: (context) => GetLocalVideoController()),
        ChangeNotifierProvider(create: (context) => LeaderBoardProvider()),
        ChangeNotifierProvider(create: (context) => LiveClassController()),
        ChangeNotifierProvider(create: (context) => CertificateController()),
        ChangeNotifierProvider(
            create: (context) => UserProfileEditController()),
        ChangeNotifierProvider(
            create: (context) => PerformanceAmalysisProvider())
      ],
      child: MyApp(
        env: this,
      ),
    ));
  }
}

enum EnvironmentType { development, staging, production }
