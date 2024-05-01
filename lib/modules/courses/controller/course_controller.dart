import 'package:samastha/modules/courses/models/course_chapter_details_models.dart';
import 'package:samastha/modules/courses/models/course_chapters_model.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/modules/courses/models/my_courses_model.dart';
import 'package:samastha/modules/courses/repository/course_repository.dart';

class CourseController {
  CourseRepository repository = CourseRepository();

  Future<List<CourseModel>> fetchCourses(bool isPopularOnly) async {
    try {
      return await repository.fetchCourses(isPopularOnly);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<MyCourse>> fetchPurchasedCourses() async {
    try {
      return await repository.fetchPurchasedCourses();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CourseModel> courseDetail(int courseId) async {
    try {
      return await repository.courseDetail(courseId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CourseChaptersData> fetchCourseChapters(int courseId, String type,
      {bool isCompleted = false}) async {
    try {
      return await repository.fetchCourseChapters(courseId, type, isCompleted);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ChapterDetailsModel> fetchChapterDetails(int lessonId) async {
    try {
      return await repository.fetchChapterDetails(lessonId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> saveCourse(int chapterId) async {
    try {
      return await repository.saveCourse(chapterId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> saveDuration(int materialId, String duration) async {
    try {
      return await repository.saveDuration(materialId, duration);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> submitPopupQuestion(int studentId,int questionId, int optionId) async {
    try {
      return await repository.submitPopupQuestion(studentId,questionId,optionId);
    } catch (e) {
      return Future.error(e);
    }
  }
}
