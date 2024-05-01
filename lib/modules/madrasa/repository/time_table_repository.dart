import 'dart:developer';

import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/madrasa/models/batch_lesson_model.dart';
import 'package:samastha/modules/madrasa/models/time_table_subjects_model.dart';
import 'package:samastha/modules/student/models/academic_calender_model.dart';

class TimeTableRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<TimeTableSubjectsModel>> fetchSubjects(
      {required int day, required int month, required int year}) async {
    try {
      final response = await dioClient.post(Urls.getSubjectsUrl, data: {
        "year": year,
        "month": month,
        "day": day
      }); //todo - remove day from here monthly data is showing here
      log(response.toString());
      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        print('data is emptyy ');
        return List<TimeTableSubjectsModel>.empty();
      }
      var abc = List.generate(
        data.length,
        (index) {
          return TimeTableSubjectsModel.fromJson(data[index]);
        },
      );
      print('data is not empty $abc');
      return abc;
    } catch (e) {
      print('error getsubj : $e');
      throw ApiException(e);
    }
  }

  Future<List<TimeTableSubjectsModel>> fetchSubjectsParents(
      {required int day, required int month, required int year}) async {
    try {
      final response = await dioClient.post(Urls.getSubjectsUrl, data: {
        "year": year,
        "month": month,
        "day": day
      }, queryParameters: {
        'student_id': IsParentLogedInDetails.getStudebtID()
      }); //todo - remove day from here monthly data is showing here
      log(response.toString());
      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        print('data is emptyy ');
        return List<TimeTableSubjectsModel>.empty();
      }
      var abc = List.generate(
        data.length,
        (index) {
          return TimeTableSubjectsModel.fromJson(data[index]);
        },
      );
      print('data is not empty $abc');
      return abc;
    } catch (e) {
      print('error getsubj : $e');
      throw ApiException(e);
    }
  }

  Future<List<BatchLessonModel>> fetchBatchLessons(
      {required int batchLessonId, required String type}) async {
    try {
      final response = await dioClient.post(Urls.batchLessonUrl,
          data: {"batch_lesson_id": batchLessonId, "type": type});

      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        return List<BatchLessonModel>.empty();
      }
      var abc = List.generate(
        data.length,
        (index) {
          return BatchLessonModel.fromJson(data[index]);
        },
      );
      return abc;
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<AcademicCalenderModel> academicCalendar(
      int year, int month, int day) async {
    try {
      final response = await dioClient.post(Urls.academicCalenderUrl,
          data: {"year": year, "month": month, "day": day});

      return AcademicCalenderModel.fromJson(response.data['data']);
    } catch (e) {
      print('error : $e');
      return throw ApiException(e);
    }
  }
}
