import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/user_details_model.dart';
import 'package:samastha/modules/parent/model/kids_model.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class UserRepository {
  final DioClient dioClient = di.sl<DioClient>();

  updateProfile(LoginResponse model) async {
    try {
      final response =
          await dioClient.put('${Urls.user}/${model.id}', data: model.toJson());
      print(response.data);
      SnackBarCustom.success(response.data['message'] ?? '');
      return true;
    } catch (e) {
      print(e);
      return throw ApiException(e);
    }
  }

  Future<UserDetailsModel> viewProfile(int userId) async {
    try {
      final response = await dioClient.get(
        '${Urls.user}/$userId',
      );
      return UserDetailsModel.fromJson( response.data['data']);
    } catch (e) {
      print('errorrs $e');
      return throw ApiException(e);
    }
  }

  setPassword(String password) async {
    try {
      final response = await dioClient.post(Urls.setPassword, data: {
        "pin": password,
      });
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  pinCheck(String password) async {
    try {
      final response = await dioClient.post(Urls.checkPin, data: {
        "pin": password,
      });
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<KidsModel>> fetchKids() async {
    try {
      final response = await dioClient.get(Urls.kidsList);
      var data = response.data['data']['data'];
      return List.generate(
          data.length, (index) => KidsModel.fromJson(data[index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
