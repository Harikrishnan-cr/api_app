import 'package:dio/dio.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/general/model/category_model.dart';
import 'package:samastha/modules/parent/model/application_model.dart';
import 'package:samastha/modules/student/models/delete_account_response.dart';
import 'package:samastha/modules/student/models/fee_payment_model.dart';
import 'package:samastha/modules/student/models/register_student_model.dart';
import 'package:samastha/modules/student/models/student_profile_model.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class AdmissionRepository {
  final DioClient dioClient = di.sl<DioClient>();

  // Future<InstructionModel> getAdmissionInstructions(String type) async {
  //   try {
  //     final response =
  //         await dioClient.post(Urls.instructions, data: {'type': type});

  //     return InstructionModel.fromJson(response.data['data']['data'][0]);
  //   } catch (e) {
  //     return throw ApiException(e);
  //   }
  // }

  Future<List<String>?> getAdmissionInstructionList(String type) async {
    try {
      final response =
          await dioClient.post(Urls.instructions, data: {'type': type});

      return List.generate(
        response.data["data"]['data'].length,
        (index) => response.data['data']['data'][index],
      );
    } catch (e) {
      print('error1 : $e');
      return throw ApiException(e);
    }
  }

  Future<List<CategoryModel>> fetchClasses() async {
    try {
      final response = await dioClient.get(Urls.classes);
      return List.generate(
          response.data['data']['data'].length,
          (index) =>
              CategoryModel.fromJson(response.data['data']['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<CategoryModel>> fetchSlots(classId) async {
    try {
      final response =
          await dioClient.post(Urls.timeSlots, data: {"class_id": classId});
      return List.generate(
          response.data['data']['data'].length,
          (index) =>
              CategoryModel.fromJson(response.data['data']['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<StudentRegisterModel> registerStudent(
      RegisterStudentModel registerStudentModel) async {
    try {
      final response = await dioClient.post(Urls.parentAdmission,
          data: await registerStudentModel.toJson());
      SnackBarCustom.success(response.data['message']);
      return StudentRegisterModel.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<ApplicationModel>> fetchApplications() async {
    try {
      final response = await dioClient.post(Urls.applications);
      return List.generate(response.data['data'].length,
          (index) => ApplicationModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<StudentProfileModel> fetchProfile() async {
    try {
      final response = await dioClient.post(Urls.fetchStudentProfile);

      return StudentProfileModel.fromJson(response.data['data']);
    } catch (e) {
      print('profile error : $e');
      return throw ApiException(e);
    }
  }

  Future<StudentProfileModel> fetchProfileparent(int studentId) async {
    try {
      final response = await dioClient.post(Urls.fetchStudentProfile,
          queryParameters: {'student_id': studentId});

      return StudentProfileModel.fromJson(response.data['data']);
    } catch (e) {
      print('profile error : $e');
      return throw ApiException(e);
    }
  }

  Future<String> checkPayment(String applicationNo) async {
    try {
      final response = await dioClient.post(Urls.checkPaymentUrl, data: {
        "application_no": applicationNo,
      });

      return response.data['data']['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<FeePaymentModel> feePayment() async {
    try {
      final response = await dioClient.get(Urls.feePayment);

      return FeePaymentModel.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<PasswordResetRespJsonModel> updateProfilePic(String filePath) async {
    try {
      String fileName = filePath.isEmpty ? "" : filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "file": filePath.isEmpty
            ? null
            : await MultipartFile.fromFile(
                filePath,
                filename: fileName,
              ),
      });

      final response =
          await dioClient.post(Urls.updateProfilePicUrl, data: formData);

      return PasswordResetRespJsonModel.fromJson(response.data);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<DeleteAccountResponse> deleteAccount() async {
    try {
      final response = await dioClient.get(Urls.deleteAccountUrl);

      return DeleteAccountResponse.fromJson(response.data);
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
