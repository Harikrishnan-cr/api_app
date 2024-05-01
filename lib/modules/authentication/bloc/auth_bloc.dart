import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/password_reset.dart';
import 'package:samastha/modules/authentication/model/user_model.dart';
import 'package:samastha/modules/authentication/repository/auth_repository.dart';
import 'package:samastha/modules/authentication/screens/login_screen.dart';
import 'package:samastha/modules/authentication/screens/otp_screen.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/app_constants.dart';

class AuthBloc {
  static AuthBloc i = di.sl<AuthBloc>();

  AuthRepository repository = AuthRepository();

  UserModel? registerModel;

  checkTokenExists() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (preferences.containsKey(AppConstants.userKey)) {
        AppConstants.loggedUser =
            loginResponseFromJson(preferences.getString(AppConstants.userKey)!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  clearSharedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // await removingOneSignalExternalUserId();
    preferences.remove(AppConstants.tokenKey);
    preferences.remove(AppConstants.userKey);
    AppConstants.loggedUser = null;

    //navigate to login screen
    Navigator.pushAndRemoveUntil(
        AppConstants.globalNavigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  Future setUserToken(LoginResponse model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(AppConstants.tokenKey, model.accessToken ?? '');
    AppConstants.loggedUser = model;
    preferences.setString(
      AppConstants.userKey,
      loginResponseToJson(model),
    );
  }

  logout() async {
    try {
      // final bool? response = await repository.logout();

      // if (response ?? false) {
      await clearSharedData();
      // }
    } catch (e) {
      return SnackBarCustom.success(e.toString());
    }
  }

  deleteAccount() async {
    try {
      // final bool? response = await repository.deleteAccount();
      // if (response ?? false) {
      //   await clearSharedData();
      // }
    } catch (e) {
      // return AppConstants.showSnackbar(e.toString());
    }
  }

  Future<LoginResponse?> login(
    String email,
    String password,
  ) async {
    try {
      LoginResponse response = await repository.login(email, password);
      await setUserToken(response);
      return response;
    } catch (e) {
      // print(e);
      SnackBarCustom.success(e.toString());
      return null;
    }
  }
  
  Future<PasswordResetModel?> changePassword(
      String username, String password, String confirmPassword) async {
    try {
      return await repository.changePassword(
          username, password, confirmPassword);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return null;
    }
  }

  resendPasswordResetLink(String emailAddress) async {
    try {
      // String message = await repository.resendPasswordResetLink(emailAddress);
      // AppConstants.showSnackbar(message);
      return true;
    } catch (e) {
      // AppConstants.showSnackbar(e.toString());
      return false;
    }
  }

  forgotPassword(String emailAddress) async {
    try {
      // return await repository.forgotPassword(emailAddress);
    } catch (e) {
      // AppConstants.showSnackbar(e.toString());
      return false;
    }
  }

  

  resetPassword(String password, String confirmPassword, String token,
      String email) async {
    try {
      // return await repository.resetPassword(
      //     password, confirmPassword, token, email);
    } catch (e) {
      // AppConstants.showSnackbar(e.toString());
      return false;
    }
  }

  Future<void> requestTOTP(BuildContext context, String phoneNumber,
      {int? prevToken, Function? callback,bool? isResetPassword,String? resetPhoneNo}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: prevToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve on Android or if the app already received the SMS code.
      },
      verificationFailed: (FirebaseAuthException e) {
        var message = '';
        switch (e.code) {
          case 'invalid-phone-number':
            message = "Invalid phone number";
            break;
          case 'too-many-requests':
            message =
                "This number have been blocked due to unusual activity. Try again later.";
            break;
          default:
            message = 'Something went wrong ${e.message}';
            break;
        }

        SnackBarCustom.success(message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (prevToken == null) {
          if (callback != null) {
            callback();
          }
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                  resendToken: resendToken,isResetPassword: isResetPassword ?? false,resetPhoneNo: resetPhoneNo),
            ),
          );
        } else {
          SnackBarCustom.success('Code sent');
        }
        // set loader false
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> checkPhoneNumber(String phone) async {
    try {
      return await repository.checkPhone(phone);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
    }
  }

  Future<bool> checkPasswordResetPhoneNumber(String phone) async {
    try {
      return await repository.checkPasswordResetPhoneNumber(phone);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
    }
  }

  Future<UserCredential?> verifyOTP(
      String verificationId, String smsCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(

        verificationId: verificationId,
        smsCode: smsCode,

      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> register() async {
    try {
      LoginResponse data = await repository.register(registerModel);
      await setUserToken(data);
      return true;
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
    }
  }
}
