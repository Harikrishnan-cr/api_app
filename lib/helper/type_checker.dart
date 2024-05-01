import 'package:samastha/widgets/custom_snackbar.dart';

class EmailChecker {
  static bool isValid(String keyword, {bool showSnackbar = true}) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(keyword)) {
      if (showSnackbar) {
        SnackBarCustom.success("Given email address is not in a valid format");
      }
      return false;
    }
    return true;
  }
}

class PasswordChecker {
  static bool isValid(String keyword, {bool showSnackbar = true}) {
    if (keyword.length < 6) {
      if (showSnackbar) {
        SnackBarCustom.success(
            "Password length should be greater than 6 characters");
      }

      return false;
    }

    return true;
  }
}

extension ValidationExtension on String {
  bool get isEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}
