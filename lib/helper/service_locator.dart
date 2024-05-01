import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';

import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/dashboard/controller/dashboard_controller.dart';
import 'package:samastha/modules/kids/modules/dashboard/controller/kids_dashboard_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DashboardController());
  sl.registerLazySingleton(() => KidsDashboardController());
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => AuthBloc());
  sl.registerLazySingleton(() => AudioPlayer());
}

class ServiceLocator {}
