import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('token ${AppConstants.loggedUser?.accessToken}');
    options.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.loggedUser?.accessToken ?? ''}',
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
      'Device-Type': Platform.isAndroid
          ? 1
          : Platform.isIOS
              ? 2
              : 0,
      'Device-Token': AppConstants.fcmToken,
      'User-Agent': AppConstants.userAgent
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      print(response.data);
      log(jsonEncode(response.data).toString());
      return response.data['status'] as bool
          ? super.onResponse(response, handler)
          : handler.reject(DioException(
              requestOptions: response.requestOptions,
              error: response.data,
              response: response,
              type: DioExceptionType.badResponse));
    } catch (e) {
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        error: "Something went wrong",
        response: response,
        type: DioExceptionType.unknown,
      ));
    }
    super.onResponse(response, handler);
  }
}

class TokenRefreshInterceptor extends Interceptor {
  final Dio dio;

  TokenRefreshInterceptor({required this.dio});

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 &&
        AppConstants.loggedUser?.accessToken != null) {
      RequestOptions? options = error.response?.requestOptions;
      Response resp;
      try {
        resp = await Dio().post(
          Urls.apiUrl + Urls.tokenRefresh,
          data: {"refreshToken": AppConstants.loggedUser?.refreshToken},
          options: Options(
            headers: options?.headers,
          ),
        );
      } on DioException {
        handler.reject(error);
        await AuthBloc().clearSharedData();
        return;
      }
      switch (resp.statusCode) {
        case 200:
          if (resp.data['response']["access_token"] != null) {
            AppConstants.loggedUser!.accessToken =
                resp.data['response']["access_token"];
            if (resp.data['response']["refreshToken"] != null) {
              AppConstants.loggedUser?.refreshToken =
                  resp.data['response']["refreshToken"];
            }
            AuthBloc().setUserToken(AppConstants.loggedUser!);
            options?.headers["Authorization"] =
                "Bearer ${AppConstants.loggedUser?.accessToken}";

            try {
              // Retry the original request
              var retryResponse = await dio.request(
                Urls.apiUrl + options!.path,
                data: options.data,
                options: Options(
                  headers: options.headers,
                  method: options.method,
                ),
              );
              handler.resolve(retryResponse);
            } on DioError catch (e) {
              handler.reject(e);
              return AuthBloc().logout();
            }
          } else {
            handler.next(error);
            return AuthBloc().logout();
          }
          break;
        default:
          handler.reject(error);
      }
    } else {
      handler.next(error);
    }
  }
}
