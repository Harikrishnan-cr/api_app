import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/modules/student/models/assignment_details_model.dart';
import 'package:samastha/modules/student/models/assignment_model.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/assignment_submit_model.dart';

class AssignmentRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<AssignmentModel>> fetchAssignments(int id, {String? type}) async {
    try {
      final response = await dioClient.post(Urls.assignmentsUrl, data: {
        "student_id": id,
        if (type != null) "status": type,
      });

      var data = response.data['data']['assignments'];

      log('sssssssssssss --------------- ${data.length}');
      if (data == null || data.isEmpty) {
        return List<AssignmentModel>.empty();
      }

      return List.generate(
        data.length,
        (index) {
          return AssignmentModel.fromJson(data[index]);
        },
      );
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<AssignmentDetailsModel> fetchAssignmentDetails(int id) async {
    try {
      final response = await dioClient.post(Urls.assignmentDetailsUrl, data: {
        "assignment_id": id,
      });
// print('dataaa ${response.data}');
//     var data = List.generate(
//       response.data["data"].length,
//       (index) => AssignmentDetailsModel.fromJson(response.data['data']),
//     );
//     print('dataaa $data');
      return AssignmentDetailsModel.fromJson(response.data['data']);
    } catch (e) {
      print('Error fetching assignment details: $e'); // Log the specific error
      throw ApiException(
          'Error fetching assignment details: $e'); // Throw an ApiException
    }
  }

  Future<AssignmentSubmitJsonModel> submitAssignment(
      int? studentId,
      int? assignmentId,
      File? worksheetFile,
      List<String> listofFilePaths) async {
    // List<MultipartFile> uploadList = [];
    // for (var file in listofFilePaths) {
    //   var multipartFile = await MultipartFile.fromFile(file);
    //   uploadList.add(multipartFile);
    // }
    try {
      String fileName =
          worksheetFile == null ? "" : worksheetFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "student_id": studentId,
        "assignment_id": assignmentId,
        "worksheet_file": worksheetFile == null
            ? null
            : await MultipartFile.fromFile(
                worksheetFile.path,
                filename: fileName,
              ),
        // "worsheets": uploadList
      });

      final response =
          await dioClient.post(Urls.submitAssignmentUrl, data: formData);

      return AssignmentSubmitJsonModel.fromJson(response.data);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<AssignmentSubmitResponse> uploadAssignment(
      int? studentId, int? worksheetId, File? worksheetFile) async {
    try {
      String fileName =
          worksheetFile == null ? "" : worksheetFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "student_id": studentId,
        "worksheet_id": worksheetId,
        "worksheet_file": worksheetFile == null
            ? null
            : await MultipartFile.fromFile(
                worksheetFile.path,
                filename: fileName,
              ),
      });

      final response =
          await dioClient.post(Urls.uploadAssignmentUrl, data: formData);

      return AssignmentSubmitResponse.fromJson(response.data);
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
