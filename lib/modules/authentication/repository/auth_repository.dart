import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/password_reset.dart';
import 'package:samastha/modules/authentication/model/user_model.dart';

class AuthRepository {
  final DioClient dioClient = di.sl<DioClient>();

  Future<bool> checkPhone(String phone) async {
    try {
      final response =
          await dioClient.post(Urls.checkPhone, data: {'username': phone});
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<bool> checkPasswordResetPhoneNumber(String phone) async {
    try {
      final response = await dioClient.post(
          Urls.checkPasswordResetPhoneNumberUrl,
          data: {'username': phone});
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<LoginResponse> register(UserModel? model) async {
    try {
      final response = await dioClient.post(Urls.register, data: {
        'phone': model?.mobile,
        'email': model?.email,
        'password': model?.password
      });
      return LoginResponse.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  login(String email, String password) async {
    try {
      final response = await dioClient.post(Urls.login, data: {
        'username': email,
        'password': password,
      });
      return LoginResponse.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<PasswordResetModel> changePassword(
      String username, String password, String confirmPassword) async {
    try {
      final response = await dioClient.post(Urls.changePassword, data: {
        "username": username,
        "password": password,
        "password_confirmation": confirmPassword
      });
      return PasswordResetModel.fromJson(response.data);
    } catch (e) {
      return throw ApiException(e);
    }



  }

// change pass after login

    Future<PasswordResetModel> changePasswordParent(
      String username, String password, String confirmPassword) async {
    try {
      final response = await dioClient.post(Urls.changePassword, data: {
        "username": username,
        "password": password,
        "password_confirmation": confirmPassword
      });
      return PasswordResetModel.fromJson(response.data);
    } catch (e) {
      return throw ApiException(e);
    }
}
}