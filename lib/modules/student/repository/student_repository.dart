import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/student_login_model.dart';

class StudentRepository {
  DioClient dioClient = di.sl<DioClient>();

  checkPin() async {
    try {
      final response = await dioClient.get(Urls.checkStudentPIN);
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  setPin(String pin) async {
    try {
      final response = await dioClient
          .post(Urls.setStudentPin, data: {"pin": pin, "confirm_pin": pin});
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<StudentLoginModel> login(String pin) async {
    try {
      final response =
          await dioClient.post(Urls.checkStudentPIN, data: {"pin": pin});

      return StudentLoginModel.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
