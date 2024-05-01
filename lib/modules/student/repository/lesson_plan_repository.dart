import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/academic_calender_model.dart';

class LessonPlanRepository {
  final DioClient dioClient = di.sl<DioClient>();

  Future<AcademicCalenderModel> academicCalendar(int year, int month) async {
    try {
      final response = await dioClient
          .post(Urls.academicCalenderUrl, data: {"year": year, "month": month});

      return AcademicCalenderModel.fromJson(response.data['data']);
    } catch (e) {
      print('error : $e');
      return throw ApiException(e);
    }
  }

  Future<AcademicCalenderModel> academicCalendarForParent(
      int year, int month) async {
    try {
      final response = await dioClient.post(Urls.academicCalenderUrl, data: {
        "year": year,
        "month": month
      }, queryParameters: {
        'student_id': IsParentLogedInDetails.getStudebtID()
      });

      return AcademicCalenderModel.fromJson(response.data['data']);
    } catch (e) {
      print('error : $e');
      return throw ApiException(e);
    }
  }
}
