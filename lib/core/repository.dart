import 'package:dio/dio.dart';
import 'package:samastha/core/urls.dart';

import '../helper/interceptors.dart';

class DataRepository {
  final Dio _client =
      Dio(BaseOptions(baseUrl: Urls.apiUrl, contentType: "application/json"));

  static DataRepository get i => _instance;
  static final DataRepository _instance = DataRepository._private();

  DataRepository._private() {
    _client.interceptors.add(LoggingInterceptor());
  }
}
