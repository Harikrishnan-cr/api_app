import 'package:samastha/modules/student/models/student_login_model.dart';
import 'package:samastha/modules/student/repository/student_repository.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class StudentController {
  StudentRepository repository = StudentRepository();

  checkPin() async {
    try {
      return await repository.checkPin();
    } catch (e) {
      //  / SnackBarCustom.success(e.toString());
      return false;
    }
  }

  Future<bool> setPin(String pin) async {
    try {
      return await repository.setPin(pin);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
    }
  }

  Future<StudentLoginModel?> login(String pin) async {
    try {
      return await repository.login(pin);
    } catch (e) {
      try {
        final bool data = await repository.setPin(pin);

        if (data) {
          return await repository.login(pin);
        } else {
          SnackBarCustom.success(e.toString());
          return null;
        }
      } catch (e) {
        SnackBarCustom.success(e.toString());
        return null;
      }
      // SnackBarCustom.success(e.toString());
      // return null;
    }
  }
}
