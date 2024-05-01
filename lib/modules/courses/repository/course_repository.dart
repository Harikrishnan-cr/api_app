import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/courses/models/course_chapter_details_models.dart';
import 'package:samastha/modules/courses/models/course_chapters_model.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/modules/courses/models/my_courses_model.dart';

class CourseRepository {
  final DioClient dioClient = di.sl<DioClient>();

  Future<CourseModel> courseDetail(int id) async {
    try {
      final response =
          await dioClient.post(Urls.courseDetail, data: {"course_id": id});
      return CourseModel.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<CourseModel>> fetchCourses(bool isPopularOnly) async {
    try {
      final response = await dioClient.get(
        Urls.coursesList,
      );
      var data = response.data['data'];
      if (isPopularOnly) {
        return List.generate(data['popularCourses'].length,
            (index) => CourseModel.fromJson(data['popularCourses'][index]));
      } else {
        return List.generate(data['normalCourses'].length,
            (index) => CourseModel.fromJson(data['normalCourses'][index]));
      }
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<MyCourse>> fetchPurchasedCourses() async {
    try {
      final response = await dioClient.post(
        Urls.myCoursesList,
      );
      var data = response.data['data'];

      return List.generate(data['courses'].length,
          (index) => MyCourse.fromJson(data['courses'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<CourseChaptersData> fetchCourseChapters(
      int courseId, String type, bool isCompleted) async {
    try {
      final response = await dioClient.post(Urls.courseChaptersUrl, data: {
        "course_id": courseId,
        "type": type,
        if (isCompleted) "Status": "completed"
      });
      var data = response.data['data'];
      return CourseChaptersData.fromJson(data);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<ChapterDetailsModel> fetchChapterDetails(int lessonId) async {
    try {
      final response = await dioClient
          .post(Urls.chapterDetailssUrl, data: {"lesson_id": lessonId});
      var data = response.data['data'];
      return ChapterDetailsModel.fromJson(data);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<bool> saveCourse(chapterId) async {
    try {
      final response = await dioClient
          .post(Urls.saveCourseUrl, data: {"chapter_id": chapterId});
      var data = response.data['status'];
      return data;
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<bool> saveDuration(int materialId, String duration) async {
    try {
      final response = await dioClient.post(Urls.saveDurationUrl,
          data: {"material_id": materialId, "duration": duration,"type" : "course"});
      var data = response.data['status'];
      return data;
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<bool> submitPopupQuestion(
      int studentId, int questionId, int optionId) async {
    try {
      final response = await dioClient.post(Urls.questionSubmitUrl, data: {
        "student_id": studentId,
        "questionId": questionId,
        "optionId": optionId
      });
      var data = response.data['status'];
      return data;
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
