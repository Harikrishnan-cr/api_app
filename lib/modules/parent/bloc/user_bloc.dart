import 'package:samastha/core/app_constants.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/user_details_model.dart';
import 'package:samastha/modules/parent/model/kids_model.dart';
import 'package:samastha/modules/parent/repository/user_repository.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class UserBloc {
  UserRepository repository = UserRepository();

  updateProfile(LoginResponse model) async {
    try {
      final bool response = await repository.updateProfile(model);
      if (response) {
        LoginResponse newModel = model;
        newModel.accessToken = AppConstants.loggedUser?.accessToken;
        newModel.refreshToken = AppConstants.loggedUser?.refreshToken;
        newModel.otp = 'val';
        await AuthBloc().setUserToken(newModel);
        return true;
      }
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
    }
  }

  Future<UserDetailsModel> viewProfile(int userId) async {
    try {
     return await repository.viewProfile(userId);
    } catch (e) {
      return Future.error(e);
    }
  }

  setPassword(String password) async {
    try {
      return await repository.setPassword(password);
    } catch (e) {
      SnackBarCustom.success(e.toString());
    }
  }

  pinCheck(String pin) async {
    try {
      print("object");
      return await repository.pinCheck(pin);
    } catch (e) {
      SnackBarCustom.success(e.toString());
    }
  }

 Future<List<KidsModel>> fetchKids() async {
    try {
      return await repository.fetchKids();
    } catch (e) {
      return Future.error(e);
    }
  }
}
