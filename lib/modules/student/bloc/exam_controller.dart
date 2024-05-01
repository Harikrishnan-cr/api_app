import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:samastha/modules/student/models/exam_instruction_model.dart';
import 'package:samastha/modules/student/models/exam_questions_model.dart';
import 'package:samastha/modules/student/models/mark_sheet_model.dart';
import 'package:samastha/modules/student/models/student_exams_model.dart';
import 'package:samastha/modules/student/repository/exams_respository.dart';

class ExamController {
  ExamRepositry repository = ExamRepositry();

  Future<List<ExamsModel>> fetchExams(int? studentId, {String? type}) async {
    try {
      return await repository.fetchExams(studentId, type: type);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ExamInstructionsModel>> fetchExamInstructions(
      int? examId, int? studentId) async {
    try {
      return await repository.fetchExamInstructions(examId, studentId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ExamQuestionsData?> fetchExamQuestions(int? examId) async {
    try {
      return await repository.fetchExamQuestion(examId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ExamsResultModel?> submitExam(
      ExamQuestionsData? examModel, int examId) async {
    try {
      return await repository.submitExam(examModel, examId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> examQuestionSolution(int? questionId) async {
    try {
      return await repository.fetchExamQuestionSolution(questionId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<MarkSheetModel> examMarks(int? examId) async {
    try {
      return await repository.examMarks(examId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<File> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    return File(result!.files.single.path!);
  }
}
