import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/type_checker.dart';
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/model/user_details_model.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/general/bloc/core_bloc.dart';
import 'package:samastha/modules/general/model/country_model.dart';
import 'package:samastha/modules/general/screens/common_search_result.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/modules/parent/bloc/edit_profile_provider.dart';
import 'package:samastha/modules/parent/bloc/user_bloc.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.isAfterLogin});
  static const path = '/profile-edit';
  final bool isAfterLogin;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var formKey = GlobalKey<FormState>();

  bool showDetails = false;

  bool isSameAddress = true;

  Gender gender = Gender.male;

  CoreBloc coreBloc = CoreBloc();

  late Future<List<CountryModel>> countriesFuture;

  LoginResponse? model = AppConstants.loggedUser;

  UserDetailsModel? userDetailsModel;

  CountryModel? selectedCountry;
  CountryModel? selectedState;

  CountryModel? selectedCommunicationCountry;
  CountryModel? selectedCommunicationState;

  // final fullnameController = TextEditingController();
  // final phoneNumberController = TextEditingController();

  UserBloc bloc = UserBloc();

  @override
  void initState() {
    isSameAddress = model?.isSameAddress ?? false;
    Provider.of<EditProfileProvider>(context, listen: false)
        .initTextFieldData(widget.isAfterLogin);
    _initTextFieldData().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.delayed(const Duration(seconds: 2))
            .then((value) => setState(() {}));
      });
    });

    // fetch countries list
    // countriesFuture = coreBloc.countriesList();

    gender = model?.gender == null
        ? Gender.male
        : model?.gender == 'male'
            ? Gender.male
            : Gender.female;
    isSameAddress = model?.isSameAddress ?? false;

    setState(() {
      model?.gender = gender.name;
      model?.isSameAddress = isSameAddress;
    });
    super.initState();
  }

  Future<void> _initTextFieldData() async {
    userDetailsModel = await bloc.viewProfile(model!.id!);
    model?.dob = widget.isAfterLogin
        ? (model?.dob ?? DateFormat('yyyy/MM/dd').parse(userDetailsModel!.dob!))
        : null;
    model?.gender = model?.gender ?? userDetailsModel?.gender;
    model?.name = userDetailsModel?.name;
    model?.phoneNumber = model?.phoneNumber ?? userDetailsModel?.phoneNumber;
    model?.homeAddress = model?.homeAddress ?? userDetailsModel?.address;
    model?.homeCountryId =
        model?.homeCountryId ?? userDetailsModel?.fkCountryId;
    isSameAddress = model?.isSameAddress ?? false;
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
    setState(() {});
    // fullnameController.text = userDetailsModel?.name ?? '';
    // phoneNumberController.text = userDetailsModel?.phoneNumber ?? '';
    // if(widget.isAfterLogin) {
    //   userDetailsModel = await bloc.viewProfile(model!.id!);
    //   fullnameController.text = userDetailsModel?.name ?? '';
    //   phoneNumberController.text = userDetailsModel?.phoneNumber ?? '';
    // }
    // if (AppConstants.tempRegisterModel!=null && widget.isAfterLogin){
    //   fullnameController.text = userDetailsModel?.name ?? '';
    //   phoneNumberController.text = userDetailsModel?.phoneNumber ?? '';
    //   userDetailsModel = UserDetailsModel(
    //     email: AppConstants.tempRegisterModel?.email,
    //     name: AppConstants.tempRegisterModel?.name,
    //     phoneNumber: AppConstants.tempRegisterModel?.mobile,
    //   );
    // }
  }

  Widget extraForms() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Home address",
          style: titleLarge.darkBG,
        ),
        const Gap(29),
        TextFieldCustom(
          validator: (value) {
            if (widget.isAfterLogin &&
                AppConstants.loggedUser?.role == 'student') {
              return null;
            }
            if (value == null || value.isEmpty) {
              return 'Enter home address';
            }
            return null;
          },
          hintStyle: labelLarge.copyWith(color: ColorResources.darkBG),
          hintText: 'Address',
          maxLines: 6,
          minLines: 4,
          keyboardType: TextInputType.multiline,
          initialValue: model?.homeAddress ?? '',
          onChanged: (text) {
            model?.homeAddress = text;
          },
        ),
        const Gap(16),
        TextFieldCustom(
          controller: TextEditingController(text: selectedCountry?.title),
          readOnlyField: true,
          validator: (value) {
            if (selectedCountry == null) {
              return 'Choose a country';
            }
            return null;
          },
          onTap: () async {
            final CountryModel? result = //open country list
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomSearchResult<CountryModel>(
                        title: 'Countries',
                        search: (p0) {
                          return coreBloc.fetchCountriesList(p0);
                        },
                      ),
                    ));
            FocusManager.instance.primaryFocus?.unfocus();
            if (result != null) {
              setState(() {
                selectedCountry = result;
                selectedState = null;
                model?.homeCountryId = result.id;
              });
            }
          },
          // isEnabled: false,
          labelText: 'Country',
          suffixWidget: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Assets.svgs.dropdown.svg(),
          ),
        ),
        if (selectedCountry != null) ...[
          const Gap(12),
          TextFieldCustom(
            validator: (value) {
              if (selectedState == null) {
                return 'Choose a state';
              }
              return null;
            },
            controller: TextEditingController(text: selectedState?.title),
            onTap: () async {
              final CountryModel? result = //open state list
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomSearchResult<CountryModel>(
                          title: 'State',
                          search: (p0) {
                            return coreBloc.fetchStateList(
                                selectedCountry!.id!, p0);
                          },
                        ),
                      ));
              FocusManager.instance.primaryFocus?.unfocus();
              if (result != null) {
                setState(() {
                  selectedState = result;
                  model?.homeStateId = result.id;
                });
              }
            },
            readOnlyField: true,
            labelText: 'State',
            suffixWidget: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Assets.svgs.dropdown.svg(),
            ),
          ),
        ],
        const Gap(29),
        Visibility(
          visible: !(AppConstants.loggedUser?.role == 'student'),
          child: Column(
            children: [
              Text(
                'Communication Address',
                style: titleLarge.darkBG,
              ),
              const Gap(31),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSameAddress = !isSameAddress;
                    model?.isSameAddress = isSameAddress;
                  });
                },
                child: Row(
                  children: [
                    isSameAddress
                        ? Assets.svgs.boxChecked.svg()
                        : Assets.svgs.mainCheckboxInactive.svg(),
                    const Gap(16),
                    Text(
                      'Same as home address',
                      style: bodyMedium.darkBG,
                    )
                  ],
                ),
              ),
              const Gap(29),
              if (!isSameAddress) ...[
                TextFieldCustom(
                  keyboardType: TextInputType.multiline,
                  hintStyle: labelLarge.copyWith(color: ColorResources.darkBG),
                  hintText: 'Address',
                  initialValue: model?.communicationAddress ?? '',
                  onChanged: (text) {
                    model?.communicationAddress = text;
                  },
                  maxLines: 6,
                  minLines: 4,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'enter communication address';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                GestureDetector(
                  onTap: () async {
                    final CountryModel? result = //open country list
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomSearchResult<CountryModel>(
                                title: 'Countries',
                                search: (p0) {
                                  return coreBloc.fetchCountriesList(p0);
                                },
                              ),
                            ));
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (result != null) {
                      setState(() {
                        selectedCommunicationCountry = result;
                        selectedCommunicationState = null;
                        model?.communicationCountryId = result.id;
                      });
                    }
                  },
                  child: TextFieldCustom(
                    // initialValue: selectedCommunicationCountry?.title ?? '',
                    readOnlyField: true,
                    controller: TextEditingController(
                        text: selectedCommunicationCountry?.title ?? ''),
                    // onTap: () async {
                    //   final CountryModel? result = //open country list
                    //       await Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) =>
                    //                 CustomSearchResult<CountryModel>(
                    //               title: 'Countries',
                    //               search: (p0) {
                    //                 return coreBloc.fetchCountriesList(p0);
                    //               },
                    //             ),
                    //           ));
                    //   FocusManager.instance.primaryFocus?.unfocus();
                    //   if (result != null) {
                    //     setState(() {
                    //       selectedCommunicationCountry = result;
                    //       selectedCommunicationState = null;
                    //       model?.communicationCountryId = result.id;
                    //     });
                    //   }
                    // },
                    isEnabled: false,
                    labelText: 'Country',
                    suffixWidget: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Assets.svgs.dropdown.svg(),
                    ),
                    validator: (value) {
                      if (selectedCountry == null) {
                        return 'Choose a country';
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(12),
                GestureDetector(
                  onTap: () async {
                    final CountryModel? result = //open state list
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomSearchResult<CountryModel>(
                                title: 'State',
                                search: (p0) {
                                  return coreBloc.fetchStateList(
                                      selectedCountry!.id!, p0);
                                },
                              ),
                            ));
                    if (result != null) {
                      setState(() {
                        selectedCommunicationState = result;
                        model?.communicationStateId = result.id;
                      });
                    }
                  },
                  child: TextFieldCustom(
                    controller: TextEditingController(
                        text: selectedCommunicationState?.title ?? ''),
                    // onTap: () async {
                    //   final CountryModel? result = //open state list
                    //       await Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) =>
                    //                 CustomSearchResult<CountryModel>(
                    //               title: 'State',
                    //               search: (p0) {
                    //                 return coreBloc.fetchStateList(
                    //                     selectedCountry!.id!, p0);
                    //               },
                    //             ),
                    //           ));
                    //   if (result != null) {
                    //     setState(() {
                    //       selectedCommunicationState = result;
                    //       model?.communicationStateId = result.id;
                    //     });
                    //   }
                    // },
                    isEnabled: false,
                    labelText: 'State',
                    suffixWidget: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Assets.svgs.dropdown.svg(),
                    ),
                    validator: (value) {
                      if (selectedState == null) {
                        return 'Choose a state';
                      }
                      return null;
                    },
                  ),
                ),
              ]
            ],
          ),
        )
      ]);

  changeViewMode() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  List<Widget> coreForms() => [
        TextFieldCustom(
          labelText: 'Full Name',
          hintText: 'Full Name',
          // controller: fullnameController,
          initialValue: model?.name ?? '',
          // initialValue: widget.isAfterLogin ? userDetailsModel?.name : model?.name ?? '',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter full name';
            }
            return null;
          },
          onChanged: (text) {
            model?.name = text;
          },
        ),
        const Gap(12),
        TextFieldCustom(
          isEnabled: false,
          labelText: 'Mobile Number',
          hintText: 'Mobile Number',
          readOnlyField: true,
          keyboardType: TextInputType.phone,
          // controller: phoneNumberController,
          initialValue: model?.phoneNumber ?? '',
          // initialValue: widget.isAfterLogin ? userDetailsModel?.phoneNumber :  model?.phoneNumber ?? '',
          validator: (value) {
            if (widget.isAfterLogin &&
                AppConstants.loggedUser?.role == 'student') {
              return null;
            }
            if (value == null || value.isEmpty) {
              return 'Enter mobile number';
            }
            return null;
          },
          onChanged: (text) {
            model?.phoneNumber = text;
          },
        ),
        const Gap(12),
        TextFieldCustom(
          labelText: 'Email',
          hintText: 'Email',
          initialValue: model?.email ?? '',
          onChanged: (text) {
            model?.email = text;
          },
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null) {
              return 'Enter email address';
            } else if (!EmailChecker.isValid(value)) {
              return 'Not a valid email format';
            }
            return null;
          },
        ),
        const Gap(12),
        DatePickerTextField(
          onChanged: (value) {
            print('dob val : $value');
            if (value != null) model?.dob = value;
          },
          value: model?.dob,
          labelText: 'DD-MM-YYYY',
          hintText: 'DD-MM-YYYY',
          initialDate: DateTime(DateTime.now().year - 5, DateTime.now().month,
              DateTime.now().day),
          lastDate: DateTime(DateTime.now().year - 5, DateTime.now().month,
              DateTime.now().day),
          pickFromFuture: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Choose date of birth';
            }
            return null;
          },
        ),
        const Gap(12),
        Text(
          'Gender',
          style: labelLarge.darkBG,
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    gender = Gender.male;
                    model?.gender = gender.name;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff32A337).withOpacity(.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.svgs.maleIcon
                          .svg(height: gender == Gender.male ? 22 : null),
                      const Gap(12),
                      Text(
                        'Male',
                        style: gender == Gender.male
                            ? button.darkBG
                            : labelLarge.darkBG,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    gender = Gender.female;
                    model?.gender = gender.name;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff1696BB).withOpacity(.4),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 30,
                          spreadRadius: 0,
                          offset: Offset(0, 10),
                          color: Color(0xfff0f0f0),
                        )
                      ]),
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.svgs.femaleIcon
                          .svg(height: gender == Gender.female ? 22 : null),
                      const Gap(12),
                      Text(
                        'Female',
                        style: gender == Gender.female
                            ? button.darkBG
                            : labelLarge.darkBG,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    log('user name ${model?.name} home address is ${model?.homeAddress}');
    print(
        'object selectedCommunicationState ${selectedCommunicationState?.title} : ${selectedCommunicationState?.id}');
    return Consumer<EditProfileProvider>(
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: Padding(
          padding: pagePadding.copyWith(bottom: 30),
          child: widget.isAfterLogin
              ? null
              : SubmitButton(
                  showDetails ? "Submit" : 'Next',
                  onTap: (loader) async {
                    if (showDetails == true) {
                      if (formKey.currentState?.validate() ?? false) {
                        if (model?.isSameAddress ?? false) {
                          model?.communicationAddress = model?.homeAddress;
                          model?.communicationCountryId = selectedCountry?.id;
                          model?.communicationStateId = selectedState?.id;
                        }
                        // profile update api call
                        setState(() {
                          loader();
                        });

                        final bool result = await bloc.updateProfile(model!);
                        setState(() {
                          loader();
                        });
                        if (result) {
                          if (AppConstants.loggedUser?.role == 'kid') {
                            Navigator.pushNamedAndRemoveUntil(context,
                                KidsDashboardScreen.path, (route) => false);
                          } else {
                            Navigator.pushNamedAndRemoveUntil(context,
                                DashboardScreen.path, (route) => false);
                          }
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   CupertinoPageRoute(
                          //       builder: (context) =>
                          //        const DashboardScreen()),
                          //   (route) => false,
                          // );
                        }
                      }
                    } else {
                      if (formKey.currentState?.validate() ?? false) {
                        changeViewMode();
                      }
                    }
                  },
                ),
        ),
        appBar: SimpleAppBar(
          title: widget.isAfterLogin ? 'Edit profile' : 'Create Account',
          iconColor: Colors.black,
          leadingWidget: showDetails
              ? GestureDetector(
                  onTap: () => changeViewMode(),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                )
              : widget.isAfterLogin
                  ? GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : null,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _initTextFieldData().whenComplete(() {
              setState(() {});
            });
          },
          child: SafeArea(
              child: SingleChildScrollView(
            padding: pagePadding,
            child: Form(
              key: formKey,
              child: widget.isAfterLogin
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...coreForms(),
                        const Gap(24),
                        extraForms(),
                        const Gap(32),
                        SubmitButton(
                          'Update',
                          onTap: (loader) async {
                            if (formKey.currentState?.validate() ?? false) {
                              model?.homeCountryId = selectedCountry?.id;
                              model?.homeStateId = selectedState?.id;
                              if (model?.isSameAddress ?? false) {
                                model?.communicationAddress =
                                    model?.homeAddress;
                                model?.communicationCountryId =
                                    selectedCountry?.id;
                                model?.communicationStateId = selectedState?.id;
                              }
                              //profile update api call
                              setState(() {
                                loader();
                              });
                              final bool result =
                                  await bloc.updateProfile(model!);
                              setState(() {
                                loader();
                              });

                              if (result) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen()),
                                  (route) => false,
                                );
                              }
                            }
                          },
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!showDetails) ...coreForms() else extraForms(),
                      ],
                    ),
            ),
          )),
        ),
      ),
    );
  }
}

enum Gender { none, male, female }
