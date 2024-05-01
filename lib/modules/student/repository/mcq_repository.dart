import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;

import 'package:samastha/modules/student/models/mcq_mark_model.dart';
import 'package:samastha/modules/student/models/mcq_question_paper.dart';

class MCQRepository {
  final DioClient dioClient = di.sl<DioClient>();

  Future<List<String>> fetchInstructions(int studentId) async {
    try {
      final response = await dioClient
          .post(Urls.mcqInstructions, data: {"studentId": studentId});
      //     print('response ${response.data['data'][0]}');
      // var abc = McqInstructionModel.fromJson(response.data['data'][0]);
      // print('print abc : $abc');
      AppConstants.temExamIdMCQ = response.data['data'][0]["id"];
      return List.generate(response.data['data'][0]["instructions"].length,
          (index) => response.data['data'][0]["instructions"][index]);
    } catch (e) {
      print('instrc error $e');
      return throw ApiException(e);
    }
  }

  Future<McqQuestionPaperModel> fetchQuestionPaper(int examId) async {
    try {
      final response = await dioClient
          .post(Urls.mcqQuestionPaper, data: {"exam_id": examId});
      return McqQuestionPaperModel.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return throw ApiException(e);
    }
  }

  Future<String> fetchSolution(int questionId) async {
    try {
      final response = await dioClient
          .post(Urls.solution, data: {"question_id": questionId});
      return response.data['data'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<MCQMarkModel> submitQuiz(McqQuestionPaperModel examModel) async {
    try {
      final response =
          await dioClient.post(Urls.submitMCQQuiz, data: examModel.toJson());
      return MCQMarkModel.fromJson(
        response.data['data'],
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
