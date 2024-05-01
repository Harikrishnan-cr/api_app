import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/madrasa/models/subjects_model.dart';
import 'package:samastha/modules/madrasa/models/usthad_model.dart';

class MadrasaRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<SubjectModel>> fetchSubject(int? classId, int? batchId) async {
    try {
      final response = await dioClient.post(
        Urls.fetchSubjects,
        data: {"class_id": classId, "batch_id": batchId},
      );

      return List.generate(
        response.data["data"].length,
        (index) => SubjectModel.fromJson(response.data['data'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<LessonMediaModel>> fetchLessons(
      int? subjectId, int? batchId, String type) async {
    try {
      final response = await dioClient.post(Urls.fetchSubjectsLessons,
          data: {"subject_id": subjectId, "batch_id": batchId, "type": type});

      return List.generate(response.data['data'].length,
          (index) => LessonMediaModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<LessonMediaModel>> fetchLessonsParent(
      int? subjectId, int? batchId, String type) async {
    try {
      final response = await dioClient.post(Urls.fetchSubjectsLessons, data: {
        "subject_id": subjectId,
        "batch_id": batchId,
        "type": type
      }, queryParameters: {
        'student_id': IsParentLogedInDetails.getStudebtID()
      });

      return List.generate(response.data['data'].length,
          (index) => LessonMediaModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<UsthadModel>> fetchMentorsList() async {
    try {
      final response = await dioClient.post(
        Urls.mentorsList,
      );
      return List.generate(response.data['data'].length,
          (index) => UsthadModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<UsthadModel>> fetchMentorsListForParent() async {
    try {
      final response = await dioClient.post(Urls.mentorsList, queryParameters: {
        'student_id': IsParentLogedInDetails.getStudebtID()
      });
      return List.generate(response.data['data'].length,
          (index) => UsthadModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  fetchUsthadDetails(int tutorId) async {
    try {
      final response =
          await dioClient.post(Urls.usthadDetails, data: {"tutor_id": tutorId});
      return UsthadModel.fromJson(response.data['data']);
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

  Future<bool> saveSubject(chapterId) async {
    try {
      final response = await dioClient
          .post(Urls.saveSubjectUrl, data: {"chapter_id": chapterId});
      var data = response.data['status'];
      return data;
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<bool> saveDuration(int materialId, String duration) async {
    try {
      final response = await dioClient.post(Urls.saveDurationUrl, data: {
        "material_id": materialId,
        "duration": duration,
        "type": "subject"
      });
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
