import 'package:get_storage/get_storage.dart';
import 'package:samastha/core/app_constants.dart';

class IsParentLogedInDetails {
  static bool isParentLogedIn() {
    final box = GetStorage();

    final data = box.read<bool>(AppConstants.isParentLogedIn) ?? false;
    return data;
  }

  static int getStudebtID() {
    final box = GetStorage();

    final data = box.read<int>(AppConstants.studenIdLocalName) ?? 0;
    return data;
  }
}
