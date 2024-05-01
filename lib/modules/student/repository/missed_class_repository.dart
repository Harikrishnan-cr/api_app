import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/missed_class/matching_schedules_model.dart';
import 'package:samastha/modules/student/models/missed_class/missed_class_schedule_response_model.dart';
import 'package:samastha/modules/student/models/missed_class/missed_classes_model.dart';

class MissedClassRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<MissedClassData> fetchMissedClasses(
      studentId, year, month, day) async {
    try {
      final response = await dioClient.post(Urls.missedClassesUrl, data: {
        "student_id": studentId,
        "year": year,
        "month": month,
        "date": day
      });
      return MissedClassData.fromJson(response.data['data']);
      // return List.generate(
      //   response.data["data"]['subjects'].length,
      //   (index) =>
      //       MissedSubject.fromJson(response.data['data']['subjects'][index]),
      // );
    } catch (e) {
      print('error missed : $e');
      throw ApiException(e);
    }
  }

  Future<List<String>> fetchInstructions() async {
    try {
      final response =
          await dioClient.post(Urls.instructions, data: {"type": "one_to_one"});
      // return InstructionModel.fromJson(
      //   response.data['data']['data']);
      return List.generate(
        response.data["data"]['data'].length,
        (index) => response.data['data']['data'][index],
      );
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<ScheduleDatum> fetchMatchingSchedules(
      int studentId, int missedClassId) async {
    try {
      final response = await dioClient.post(Urls.matchingSchedulesUrl,
          data: {"subject_id": studentId, "missed_class_id": missedClassId});
      return ScheduleDatum.fromJson(response.data['data']);
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<ScheduleMissedRespJsonModel> scheduleMissedClass(
      String scheduleDate, int batchId) async {
    try {
      final response = await dioClient.post(Urls.scheduleMissedClassesUrl,
          data: {"schedule_date": scheduleDate, "batch_id": batchId});
      return ScheduleMissedRespJsonModel.fromJson(response.data);
    } catch (e) {
      print('error catch $e');
      throw ApiException(e);
    }
  }

  fetchOneToOneList({bool? isComplete}) {}
}
