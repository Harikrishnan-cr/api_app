import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/authentication/model/user_details_model.dart';
import 'package:samastha/modules/general/bloc/core_bloc.dart';
import 'package:samastha/modules/parent/screens/profile_edit_screen.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

import '../../general/model/country_model.dart';

class UserProfileEditController extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  UserDetailsModel? userDetailsModel;

  bool isEditProfileLoading = false;

  Gender gender = Gender.male;

  CountryModel? selectedCountry;
  CountryModel? selectedState;

  bool isSameAsSelected = false;

  void isSameAddressSelected() {
    isSameAsSelected = !isSameAsSelected;
    notifyListeners();
  }

  void selectedCountryChnage({required CountryModel selectedCountryData}) {
    selectedCountry = selectedCountryData;
    selectedState = null;
    notifyListeners();
  }

  void selectedStateChnage({required CountryModel selectedCountryData}) {
    selectedState = selectedCountryData;

    notifyListeners();
  }

  StateAndCountryId? conuntyAndStateId;
  CoreBloc coreBloc = CoreBloc();

  UserProfileEditController() {
    onGetStudentProfileDetails();
  }

  Future<bool> onEditProfileSubmited({
    required Function({bool? isLoading}) loader,
  }) async {
    try {
      Map<String, dynamic> model = {};

      model.putIfAbsent('fullname', () => userDetailsModel?.name);
      model.putIfAbsent('dob', () => userDetailsModel?.dob);

      ///------------------------
      model.putIfAbsent('email', () => userDetailsModel?.email);
      model.putIfAbsent('mobile', () => userDetailsModel?.phoneNumber);
      // model.putIfAbsent('dob', () => userDetailsModel?.dob);
      //----------------------------
      model.putIfAbsent('gender', () => userDetailsModel?.gender);
      model.putIfAbsent('home_address', () => userDetailsModel?.address);
      model.putIfAbsent('home_state', () => conuntyAndStateId?.stateId);
      model.putIfAbsent('home_country', () => conuntyAndStateId?.countryId);
      // model.putIfAbsent(
      //     'communication_address', () => userDetailsModel?.address);
      // model.putIfAbsent(
      //     'communication_state', () => conuntyAndStateId?.stateId);
      // model.putIfAbsent(
      //     'communication_country', () => conuntyAndStateId?.countryId);

      model.putIfAbsent('home_address', () => userDetailsModel?.address);
      model.putIfAbsent('home_state', () => conuntyAndStateId?.stateId);
      model.putIfAbsent('home_country', () => conuntyAndStateId?.countryId);

      if (isSameAsSelected) {
        model.putIfAbsent('is_same_address', () => isSameAsSelected);
        model.putIfAbsent('communication_address', () => 'address empty ttt');
        model.putIfAbsent(
            'communication_state', () => conuntyAndStateId?.stateId);
        model.putIfAbsent(
            'communication_country', () => conuntyAndStateId?.countryId);
      } else {
        model.putIfAbsent('is_same_address', () => false);
        model.putIfAbsent('communication_address', () => 'address empty');
        model.putIfAbsent(
            'communication_state', () => conuntyAndStateId?.stateId);
        model.putIfAbsent(
            'communication_country', () => conuntyAndStateId?.countryId);
      }

      final Map<String, dynamic> filteredData = Map.fromEntries(model.entries
          .where((entry) => entry.value != null && entry.value != ''));
      log('filerterd map data $filteredData');
      final response = await dioClient
          .put('${Urls.user}/${AppConstants.loggedUser?.id}',
              data: filteredData)
          .whenComplete(() {
        AppConstants.loggedUser?.name = userDetailsModel?.name;
      });

      SnackBarCustom.success(response.data['message'] ?? '');

      return true;
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return false;
      // throw ApiException(e);
    }
    // loader();
    // notifyListeners();
    // Future.delayed(const Duration(seconds: 1)).whenComplete(() {
    //   log('loader chnages');
    //   loader();
    //   notifyListeners();
    // });
  }

  void onGenderChnage({required Gender genderData}) {
    gender = genderData;

    notifyListeners();
  }

  void onGetStudentProfileDetails() async {
    if (AppConstants.loggedUser?.id != null) {
      isSameAddressSelected();
      try {
        isEditProfileLoading = true;
        notifyListeners();
        await dioClient
            .get(
          '${Urls.user}/${AppConstants.loggedUser?.id}',
        )
            .then((response) {
          userDetailsModel = UserDetailsModel.fromJson(response.data['data']);
          getCountryAndState(
                  countryId: response.data['data']['fkCountryId'] ?? 0,
                  stateID: response.data['data']['fkStateId'])
              .then((stateOrCountry) {
            conuntyAndStateId = stateOrCountry;
            getStateData(
                countryId: stateOrCountry.countryId,
                stateID: stateOrCountry.stateId);
          });
        });

        log('user gender is ${userDetailsModel?.gender}');
// selectedCountry = userDetailsModel.
        if (userDetailsModel?.gender == 'male') {
          gender = Gender.male;
        } else {
          gender = Gender.female;
        }

        isEditProfileLoading = false;

        notifyListeners();
      } catch (e) {
        log('errorrs $e user id :- ${AppConstants.loggedUser?.id}');
        isEditProfileLoading = false;

        notifyListeners();

        SnackBarCustom.success('Error loading user profile details');
        throw ApiException(e);
      }
    } else {
      log('errorrs user id is empty user id :- ${AppConstants.loggedUser?.id}');
      SnackBarCustom.success('Error loading user profile details');
    }
  }

  void onGetParentProfileDetails() async {
    if (AppConstants.loggedUser?.id != null) {
      try {
        isEditProfileLoading = true;
        notifyListeners();
        await dioClient
            .get(
          '${Urls.user}/${AppConstants.loggedUser?.id}',
        )
            .then((response) {
          userDetailsModel = UserDetailsModel.fromJson(response.data['data']);
          getCountryAndState(
                  countryId: response.data['data']['fkCountryId'] ?? 0,
                  stateID: response.data['data']['fkStateId'])
              .then((stateOrCountry) {
            conuntyAndStateId = stateOrCountry;
            getStateData(
                countryId: stateOrCountry.countryId,
                stateID: stateOrCountry.stateId);
          });
        });

        log('user gender is ${userDetailsModel?.gender}');
// selectedCountry = userDetailsModel.
        if (userDetailsModel?.gender == 'male') {
          gender = Gender.male;
        } else {
          gender = Gender.female;
        }

        isEditProfileLoading = false;

        notifyListeners();
      } catch (e) {
        log('errorrs $e user id :- ${AppConstants.loggedUser?.id}');
        isEditProfileLoading = false;

        notifyListeners();

        SnackBarCustom.success('Error loading user profile details');
        throw ApiException(e);
      }
    } else {
      log('errorrs user id is empty user id :- ${AppConstants.loggedUser?.id}');
      SnackBarCustom.success('Error loading user profile details');
    }
  }

  Future<StateAndCountryId> getCountryAndState(
      {required int countryId, required int stateID}) async {
    try {
      await dioClient
          .get(
        Urls.countries,
      )
          .then((response) async {
        final countryData = List.generate(response.data['data'].length,
            (index) => CountryModel.fromJson(response.data['data'][index]));

        selectedCountry = countryData
            .where((element) {
              log('country id is ${element.id} and main id is $countryId and final');
              return element.id == countryId;
            })
            .toList()
            .first;
        log('country id is selecte c id is $selectedCountry');
        notifyListeners();
        return StateAndCountryId(countryId: countryId, stateId: stateID);
      });

      return StateAndCountryId(countryId: countryId, stateId: stateID);
    } catch (e) {
      return StateAndCountryId(countryId: countryId, stateId: stateID);
      //throw ApiException(e);
    }
  }

  void getStateData({required int countryId, required int stateID}) async {
    try {
      final response =
          await dioClient.post(Urls.states, data: {'countryId': countryId});

      final stateData = List.generate(response.data['data'].length,
          (index) => CountryModel.fromJson(response.data['data'][index]));

      selectedState = stateData
          .where((element) {
            log('state id is ${element.id} and main id is $stateID and final');
            return element.id == stateID;
          })
          .toList()
          .first;
      log('state id is selecte c id is $selectedCountry');
      notifyListeners();
    } catch (e) {
      throw ApiException(e);
    }
  }
}

class StateAndCountryId {
  int stateId;
  int countryId;

  StateAndCountryId({required this.countryId, required this.stateId});
}
