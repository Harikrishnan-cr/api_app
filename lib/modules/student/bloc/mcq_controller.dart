import 'package:samastha/modules/student/models/mcq_instructions.dart';
import 'package:samastha/modules/student/models/mcq_mark_model.dart';
import 'package:samastha/modules/student/models/mcq_question_paper.dart';
import 'package:samastha/modules/student/repository/mcq_repository.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class MCQController {
  MCQRepository repository = MCQRepository();

  Future<List<String>> fetchInstructions(int studentId) async {
    try {
      return await repository.fetchInstructions(studentId);
    } catch (e) {
      print('instrc error $e');
      return Future.error(e);
    }
  }

  Future<McqQuestionPaperModel> fetchQuestionPaper(int examId) async {
    try {
      return await repository.fetchQuestionPaper(examId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> fetchSolution(int questionId) async {
    try {
      return await repository.fetchSolution(questionId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<MCQMarkModel?> submitQuiz(
      McqQuestionPaperModel examQuestions) async {
    try {
      return await repository.submitQuiz(examQuestions);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return null;
    }
  }
}
