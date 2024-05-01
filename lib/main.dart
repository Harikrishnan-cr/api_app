import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:samastha/env/env.dart';
import 'package:samastha/modules/authentication/screens/splash_screen.dart';
import 'package:samastha/modules/madrasa/models/video_download_modal.dart';
import 'core/app_constants.dart';
import 'core/app_route.dart';
import 'theme/theme.dart';
import 'env/development_env.dart';
import 'env/production_end.dart';
import 'env/staging_env.dart';

void main() async {
  await GetStorage.init();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(VideoDownlaodModelClassAdapter().typeId)) {
    Hive.registerAdapter(VideoDownlaodModelClassAdapter());

    log('addapter registerd succefully');
  }
  getEnvironment();
}

getEnvironment() {
  // 0 - Development, 1 - Staging, 2 - Production
  // fetch environment value in const variable only.
  // set configuration --dart-define=ENVIRONMENT_TYPE=1
  // default production environment will be loaded.
  const environment = int.fromEnvironment(
    'ENVIRONMENT_TYPE',
    defaultValue: 0,
  );
  switch (EnvironmentType.values[environment]) {
    case EnvironmentType.development:
      WidgetsFlutterBinding.ensureInitialized();
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

      return DevelopmentEnv();
    case EnvironmentType.staging:
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      return StagingEnv();
    case EnvironmentType.production:
      WidgetsFlutterBinding.ensureInitialized();
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      return ProductionEnv();
    default:
      return ProductionEnv();
  }
}

class MyApp extends StatefulWidget {
  final Env env;

  const MyApp({super.key, required this.env});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // DI init

    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: ColorResources.PRIMARY),
    // );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,

      // navigation bar color
      // statusBarColor: ColorResources.primary,
      // status bar color
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppConstants.globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: '/',
      onGenerateInitialRoutes: (initialRoute) {
        return [
          CupertinoPageRoute(
              builder: (context) => const SplashScreen(),
              settings: const RouteSettings(name: '/'))
        ];
      },
      theme: themeData,
      supportedLocales: const [
        Locale('en', 'IN'),
      ],
      locale: const Locale('en', 'IN'),
      title: AppConstants.appTitle,
    );
  }
}



// admissionNumber: "SKIMVB0016",
// password: "02012018",
// queryParameters: {
//            'student_id': IsParentLogedInDetails.getStudebtID()
//          }