import 'package:samastha/modules/student/models/missed_class/missed_classes_model.dart';
import 'package:samastha/modules/student/repository/missed_class_repository.dart';

class MissedClassController {
  MissedClassRepository repository = MissedClassRepository();

  Future<MissedClassData> fetchMissedClasses(
      studentId, year, month, day) async {
    try {
      return await repository.fetchMissedClasses(studentId, year, month, day);
    } catch (e) {
      print('error missed : $e');
      return Future.error(e);
    }
  }

  Future<List<String>> fetchInstructions() async {
     try {
      return await repository.fetchInstructions();
    } catch (e) {
      return Future.error(e);
    }
  }
}
