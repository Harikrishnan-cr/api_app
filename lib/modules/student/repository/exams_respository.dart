import 'dart:developer';

import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/exam_instruction_model.dart';
import 'package:samastha/modules/student/models/exam_questions_model.dart';
import 'package:samastha/modules/student/models/mark_sheet_model.dart';
import 'package:samastha/modules/student/models/student_exams_model.dart';

class ExamRepositry {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<ExamsModel>> fetchExams(int? id, {String? type}) async {
    try {
      final response = await dioClient.post(Urls.getExamUrl, data: {
        "studentId": id,
        if (type != null) "Status": type,
      });

      var data = response.data['data']['exams'];
      if (data == null || data.isEmpty) {
        return List<ExamsModel>.empty();
      }

      return List.generate(
        data.length,
        (index) {
          log(ExamsModel.fromJson(data[index]).toString());
          return ExamsModel.fromJson(data[index]);
        },
      );
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<List<ExamInstructionsModel>> fetchExamInstructions(
      int? examId, int? studentId) async {
    try {
      final response = await dioClient.post(Urls.getExamInstructionsUrl,
          data: {"exam_id": examId, "student_id": studentId});

      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        return List<ExamInstructionsModel>.empty();
      }

      return List.generate(
        data.length,
        (index) {
          return ExamInstructionsModel.fromJson(data[index]);
        },
      );
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<ExamQuestionsData?> fetchExamQuestion(int? examId) async {
    try {
      final response = await dioClient
          .post(Urls.getExamQuestionsUrl, data: {"exam_id": examId});

      var data = response.data['data'];
      if (data == null || data.isEmpty) {
        return null;
      }

      return ExamQuestionsData.fromJson(data);
    } catch (e) {
      throw ApiException(e);
    }
  }

  Future<ExamsResultModel> submitExam(
      ExamQuestionsData? examModel, int examId) async {
    try {
      final response = await dioClient.post(Urls.submitExamUrl,
          data: examModel?.toSubmitJson(examModel, examId));
      return ExamsResultModel.fromJson(
        response.data['data'],
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<String> fetchExamQuestionSolution(int? questionId) async {
    try {
      final response = await dioClient
          .post(Urls.examSolutionUrl, data: {"question_id": questionId});
      return response.data['data'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<MarkSheetModel> examMarks(int? examId) async {
    try {
      final response =
          await dioClient.post(Urls.examMarks, data: {"exam_id": examId});
      return MarkSheetModel.fromJson(response.data['data']['examDetails']);
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
