import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/modules/general/model/category_model.dart';
import 'package:samastha/modules/parent/model/application_model.dart';
import 'package:samastha/modules/student/models/delete_account_response.dart';
import 'package:samastha/modules/student/models/fee_payment_model.dart';
import 'package:samastha/modules/student/models/instruction_model.dart';
import 'package:samastha/modules/student/models/register_student_model.dart';
import 'package:samastha/modules/student/models/student_profile_model.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/modules/student/repository/admission_repository.dart';
import 'package:samastha/modules/student/screens/student_beyond_age_screen.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class AdmissionBloc {
  List<CategoryModel> classes = [];
  List<CategoryModel> slots = [];

  AdmissionRepository repository = AdmissionRepository();

  // Future<List<InstructionModel>> getAdmissionInstructions(String type) async {
  //   try {
  //     InstructionModel withTC =
  //         await repository.getAdmissionInstructions('join_tc');
  //     InstructionModel withoutTC =
  //         await repository.getAdmissionInstructions('join_without_tc');

  //     return [withTC, withoutTC];
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future<List<List<String>?>> getAdmissionInstructionsList(String type) async {
    try {
      List<String>? withTC =
          await repository.getAdmissionInstructionList('join_tc');
      List<String>? withoutTC =
          await repository.getAdmissionInstructionList('join_without_tc');

      return [withTC, withoutTC];
    } catch (e) {
      print('error : $e');
      return Future.error(e);
    }
  }

  fetchClasses(bool isHigerClass) async {
    try {
      List<CategoryModel> data = await repository.fetchClasses();
      if (data.isNotEmpty) {
        classes.clear();
        classes.addAll(data);
        if (isHigerClass) {
          classes.removeWhere((element) => element.isFirstStandard == 1);
        } else {
          classes.removeWhere((element) => element.isFirstStandard == 0);
        }
      }
    } catch (e) {
      SnackBarCustom.success(e.toString());
    }
  }

  Future fetchSlots(classId) async {
    try {
      List<CategoryModel> data = await repository.fetchSlots(classId);
      if (data.isNotEmpty) {
        slots.clear();
        slots.addAll(data);
      }
    } catch (e) {
      SnackBarCustom.success(e.toString());
    }
  }

  Future<StudentRegisterModel?> registerStudent(
      RegisterStudentModel registerStudentModel) async {
    try {
      return await repository.registerStudent(registerStudentModel);
    } catch (e) {
      if (e.toString().contains('beyond age')) {
        Navigator.pushNamed(AppConstants.globalNavigatorKey.currentContext!,
            StudentBeyondAgeScreen.path);
      }
      SnackBarCustom.success(e.toString());
      return null;
    }
  }

  Future<List<ApplicationModel>> fetchApplications() async {
    try {
      return await repository.fetchApplications();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<StudentProfileModel> fetchProfile() async {
    try {
      return await repository.fetchProfile();
    } catch (e) {
      print('profile error 1 : $e');
      return Future.error(e);
    }
  }

  Future<StudentProfileModel> fetchProfileparentLogin(int studId) async {
    try {
      return await repository.fetchProfileparent(studId);
    } catch (e) {
      print('profile error 1 : $e');
      return Future.error(e);
    }
  }

  Future<String> checkPayment(String applicationNo) async {
    try {
      return await repository.checkPayment(applicationNo);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<FeePaymentModel> feePayment() async {
    try {
      return await repository.feePayment();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<PasswordResetRespJsonModel> updateProfilePic(String filePath) async {
    try {
      var resp = await repository.updateProfilePic(filePath);
      showErrorMessage(resp.message ?? '');
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<DeleteAccountResponse> deleteAccount() async {
    try {
      var resp = await repository.deleteAccount();
      showErrorMessage(resp.message ?? '');
      return resp;
    } catch (e) {
      return Future.error(e);
    }
  }
}
