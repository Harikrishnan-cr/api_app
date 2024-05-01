import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/madrasa/models/subjects_model.dart';
import 'package:samastha/modules/madrasa/models/usthad_model.dart';
import 'package:samastha/modules/madrasa/repository/madrasa_repository.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class MadrasaController {
  MadrasaRepository repository = MadrasaRepository();

  Future<List<SubjectModel>> fetchSubjects(int? classId, int? batchId) async {
    try {
      return await repository.fetchSubject(classId, batchId);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return Future.error(e);
    }
  }

  Future<List<LessonMediaModel>> fetchLessons(
      int? subjectId, int? batchId, String type) async {
    try {
      return await repository.fetchLessons(subjectId, batchId, type);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return Future.error(e);
    }
  }

  Future<List<LessonMediaModel>> fetchLessonsParrent(
      int? subjectId, int? batchId, String type) async {
    try {
      return await repository.fetchLessonsParent(subjectId, batchId, type);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return Future.error(e);
    }
  }

  Future<List<UsthadModel>> fetchMentorsList() async {
    try {
      return await repository.fetchMentorsList();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<UsthadModel>> fetchMentorsListParent() async {
    try {
      return await repository.fetchMentorsListForParent();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UsthadModel> fetchUsthadDetails(int tutorId) async {
    try {
      return await repository.fetchUsthadDetails(tutorId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> saveSubject(int chapterId) async {
    try {
      return await repository.saveSubject(chapterId);
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

  Future<bool> submitPopupQuestion(
      int studentId, int questionId, int optionId) async {
    try {
      return await repository.submitPopupQuestion(
          studentId, questionId, optionId);
    } catch (e) {
      return Future.error(e);
    }
  }
}
