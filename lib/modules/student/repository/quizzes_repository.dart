import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/mark_sheet_model.dart';
import 'package:samastha/modules/student/models/quizz_instruction_model.dart';
import 'package:samastha/modules/student/models/quizz_model.dart';
import 'package:samastha/modules/student/models/quizz_questions_model.dart';

class QuizzesRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<QuizzModel>> fetchQuizzes(int? studentId, {String? type}) async {
    try {
      final response = await dioClient.post(Urls.fetchQuizzesUrl, data: {
        "studentId": studentId,
        if (type != null) "Status": type,
      });

      var data = response.data['data']['exams'];
      if (data == null || data.isEmpty) {
        return List<QuizzModel>.empty();
      }

      return List.generate(
        data.length,
        (index) => QuizzModel.fromJson(data[index]),
      );
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<List<QuizzInstructionsModel>> fetchQuizzInstructions(
      int quizId, int studentId) async {
    try {
      final response = await dioClient.post(Urls.fetchQuizzInstructionsUrl,
          data: {"quiz_id": quizId, "student_id": studentId});

      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        return List<QuizzInstructionsModel>.empty();
      }

      return List.generate(
        data.length,
        (index) => QuizzInstructionsModel.fromJson(data[index]),
      );
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<QuizzQuestionsData?> fetchQuizzQuestions(int quizId) async {
    try {
      final response = await dioClient
          .post(Urls.fetchQuizzQuestionsUrl, data: {"quiz_id": quizId});

      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        return null;
      }

      return QuizzQuestionsData.fromJson(data);
    } catch (e) {
      print('error quizz: $e');
      throw ApiException(e);
    }
  }

  Future<String> fetchQuizSolution(int? questionId) async {
    try {
      final response = await dioClient
          .post(Urls.fetchQuizzSolutionsUrl, data: {"question_id": questionId});
      return response.data['data'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<QuizzResultJsonModel> submitQuiz(
      QuizzQuestionsData? quizModel, int quizId) async {
    try {
      final response = await dioClient.post(Urls.submitQuizzUrl,
          data: quizModel?.toSubmitJson(quizModel, quizId));
      return QuizzResultJsonModel.fromJson(
        response.data['data'],
      );
    } catch (e) {
      print(e);
      return throw ApiException(e);
    }
  }

  Future<MarkSheetModel> quizMarks(int? examId) async {
    try {
      final response =
          await dioClient.post(Urls.quizzMarkUrl, data: {"exam_id": examId});
      return MarkSheetModel.fromJson(response.data['data']['examDetails']);
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
