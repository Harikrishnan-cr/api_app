import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/user_details_model.dart';
import 'package:samastha/modules/general/bloc/core_bloc.dart';
import 'package:samastha/modules/general/model/country_model.dart';
import 'package:samastha/modules/parent/bloc/user_bloc.dart';

class EditProfileProvider extends ChangeNotifier {
  CountryModel? selectedCountry;
  CountryModel? selectedState;

  CountryModel? selectedCommunicationCountry;
  CountryModel? selectedCommunicationState;
  LoginResponse? model = AppConstants.loggedUser;
  UserDetailsModel? userDetailsModel;

  UserBloc bloc = UserBloc();
  CoreBloc coreBloc = CoreBloc();

  Future<void> initTextFieldData(bool isAfterLogin) async {
    userDetailsModel = await bloc.viewProfile(model!.id!);
    model?.dob = isAfterLogin
        ? (model?.dob ?? DateFormat('yyyy/MM/dd').parse(userDetailsModel!.dob!))
        : null;
    model?.gender = model?.gender ?? userDetailsModel?.gender;
    model?.name = userDetailsModel?.name;
    model?.phoneNumber = model?.phoneNumber ?? userDetailsModel?.phoneNumber;
    model?.homeAddress = model?.homeAddress ?? userDetailsModel?.address;
    model?.homeCountryId =
        model?.homeCountryId ?? userDetailsModel?.fkCountryId;

    model?.communicationAddress =
        model?.communicationAddress ?? userDetailsModel?.cAddress;

    selectedCountry = await coreBloc.selectDefaultCountry(
        (model?.homeCountryId ?? userDetailsModel?.fkCountryId)!);

    selectedState = await coreBloc.selectDefaultState(
        (model?.homeStateId ?? userDetailsModel?.fkStateId)!,
        (model?.homeCountryId ?? userDetailsModel?.fkCountryId)!);

    selectedCommunicationCountry = await coreBloc.selectDefaultCountry(
      (model?.communicationCountryId ?? userDetailsModel?.fkCCountryId)!,
    );

    selectedCommunicationState = await coreBloc.selectDefaultState(
      (model?.communicationStateId ?? userDetailsModel?.fkCStateId)!,
      (model?.communicationCountryId ?? userDetailsModel?.fkCCountryId)!,
    );
  }
}
