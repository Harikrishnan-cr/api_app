import 'package:samastha/modules/student/models/mark_sheet_model.dart';
import 'package:samastha/modules/student/models/quizz_instruction_model.dart';
import 'package:samastha/modules/student/models/quizz_model.dart';
import 'package:samastha/modules/student/models/quizz_questions_model.dart';
import 'package:samastha/modules/student/repository/quizzes_repository.dart';

class QuizzController {
  QuizzesRepository repository = QuizzesRepository();

  Future<List<QuizzModel>> fetchQuizzes(int? studentId, {String? type}) async {
    try {
      return await repository.fetchQuizzes(studentId, type: type);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<QuizzQuestionsData?> fetchQuizzQuestions(int studentId) async {
    try {
      return await repository.fetchQuizzQuestions(studentId);
    } catch (e) {
      print('error quizz: $e');
      return Future.error(e);
    }
  }

  Future<List<QuizzInstructionsModel>> fetchQuizzeInstructions(
      int quizId, int studentId) async {
    try {
      return await repository.fetchQuizzInstructions(quizId, studentId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> fetchQuizzSolutions(int quizId) async {
    try {
      return await repository.fetchQuizSolution(quizId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<QuizzResultJsonModel?> submitQuiz(
      QuizzQuestionsData data, int quizId) async {
    try {
      return await repository.submitQuiz(data, quizId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<MarkSheetModel> quizMarks(int? examId) async {
    try {
      return await repository.quizMarks(examId);
    } catch (e) {
      return Future.error(e);
    }
  }
}
