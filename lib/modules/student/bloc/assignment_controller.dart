import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:samastha/modules/student/models/assignment_details_model.dart';
import 'package:samastha/modules/student/models/assignment_model.dart';
import 'package:samastha/modules/student/models/assignment_submit_model.dart';
import 'package:samastha/modules/student/repository/assignment_respository.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentController {
  AssignmentRepository repository = AssignmentRepository();

  Future<List<AssignmentModel>> fetchAssignments(id, {String? type}) async {
    try {
      var data = await repository.fetchAssignments(id, type: type);

      return data;
    } catch (e) {
      log('error is data is $e');
      return Future.error(e);
    }
  }

  Future<AssignmentDetailsModel> fetchAssignmentDetails(id) async {
    try {
      return await repository.fetchAssignmentDetails(id);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AssignmentSubmitJsonModel> submitAssignment(
      int? studentId,
      int? assignmentId,
      File? worksheetFile,
      List<WorkSheet>? worksheets) async {
    List<String> listOfFilePaths = [];
    worksheets?.forEach((element) {
      listOfFilePaths.add(element.answerWorksheet!.path);
    });
    try {
      return await repository.submitAssignment(
          studentId, assignmentId, worksheetFile, listOfFilePaths);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AssignmentSubmitResponse> uploadAssignment(
      int? studentId, int? worksheetId, File? worksheetFile) async {
    try {
      return await repository.uploadAssignment(
          studentId, worksheetId, worksheetFile);
    } catch (e) {
      return Future.error(e);
    }
  }

  void openPdf(String? worksheetUrl) {
    launchUrl(Uri.parse(worksheetUrl!));
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
