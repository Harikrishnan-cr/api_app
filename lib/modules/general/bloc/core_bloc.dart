// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:samastha/core/app_constants.dart';

import 'package:samastha/modules/authentication/screens/login_screen.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/general/model/country_model.dart';

import 'package:samastha/modules/general/repository/core_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/modules/parent/screens/profile_edit_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../env/env.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../authentication/model/login_response.dart';

class CoreBloc {
  CoreRepository repository = CoreRepository();

  final uuid = const Uuid();

  List<CountryModel> countriesList = [];
  List<CountryModel> stateList = [];

  int? tempCountryId;

  Future<bool> initSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //setting default values

    if (sharedPreferences.containsKey(AppConstants.userKey)) {
      AppConstants.loggedUser = loginResponseFromJson(
          sharedPreferences.getString(AppConstants.userKey)!);
    }

    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        AppConstants.userAgent = {
          'buildType': describeEnum(Env.instance.toString()).toUpperCase(),
          'appName': packageInfo.appName,
          'deviceModel': androidInfo.model,
          'deviceOS': 'ANDROID',
          'deviceAPILevel': androidInfo.version.sdkInt,
          'versionCode': packageInfo.buildNumber,
          'versionName': packageInfo.version,
          'androidVersion': androidInfo.version.release,
        };
      }
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        AppConstants.userAgent = {
          'buildType': describeEnum(Env.instance.toString()).toUpperCase(),
          'appName': packageInfo.appName,
          'deviceModel': iosInfo.utsname.machine,
          'deviceOS': 'IOS',
          'versionCode': packageInfo.buildNumber,
          'iosVersion': iosInfo.systemVersion,
          'versionName': packageInfo.version
        };
      }
    } catch (e) {
      //
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  void findLandingPage(BuildContext context) async {
    final isTokenExists = await AuthBloc().checkTokenExists();
    final isOtpNull = AppConstants.loggedUser?.otp == null;

    if (isTokenExists) {
      if (isOtpNull) {
        navigateToPage(context, const ProfileEditScreen(isAfterLogin: false));
      } else {
        if (AppConstants.loggedUser?.role == 'kid') {
          Navigator.pushNamedAndRemoveUntil(
              context, KidsDashboardScreen.path, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, DashboardScreen.path, (route) => false);
        }

        // navigateToPage(context, const DashboardScreen());
        // navigateToPage(context, const KidsDashboardScreen());
      }
    } else {
      navigateToPage(context, const LoginScreen());
    }
  }

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  skipIntroPages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(AppConstants.introKey, true);
  }

  Future<String?> getImageUrl(String path) async {
    if (path.isEmpty) return null;
    return repository.getImageUrl(path);
  }

  Future<List<CountryModel>> fetchCountriesList(String keyword) async {
    try {
      if (countriesList.isEmpty) {
        countriesList = await repository.fetchCountriesList(keyword.trim());

        return countriesList;
      } else {
        return countriesList
            .where((element) => element.title!
                .toLowerCase()
                .contains(keyword.toLowerCase().trim()))
            .toList();
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CountryModel?> selectDefaultCountry(int countryId) async {
    CountryModel? countryModel;
    countriesList = await repository.fetchCountriesList('');
    for (var element in countriesList) {
      if (element.id == countryId) {
        countryModel = element;
      }
    }
    return countryModel;
  }

  Future<CountryModel?> selectDefaultState(int stateId, int countryId) async {
    CountryModel? stateModel;
    stateList = await repository.fetchStateList(countryId);
    for (var element in stateList) {
      if (element.id == stateId) {
        stateModel = element;
      }
    }
    return stateModel;
  }

  Future<List<CountryModel>> fetchStateList(
      int countryId, String keyword) async {
    try {
      if (tempCountryId != countryId) {
        stateList = await repository.fetchStateList(countryId);
        tempCountryId = countryId;
        if (stateList.isEmpty) {
          stateList = await repository.fetchStateList(countryId);

          return stateList;
        } else {
          return stateList
              .where((element) => element.title!
                  .toLowerCase()
                  .contains(keyword.toLowerCase().trim()))
              .toList();
        }
      } else {
        return stateList
            .where((element) => element.title!
                .toLowerCase()
                .contains(keyword.toLowerCase().trim()))
            .toList();
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
