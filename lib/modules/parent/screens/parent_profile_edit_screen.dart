import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/type_checker.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/general/bloc/core_bloc.dart';
import 'package:samastha/modules/general/model/country_model.dart';
import 'package:samastha/modules/general/screens/common_search_result.dart';
import 'package:samastha/modules/parent/controller/user_profile_edit_controller.dart';
import 'package:samastha/modules/parent/screens/profile_edit_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class ParentProfileEditScreen extends StatefulWidget {
  static const String path = '/parent-profile-edit-screen';
  const ParentProfileEditScreen({super.key});

  @override
  State<ParentProfileEditScreen> createState() =>
      _ParentProfileEditScreenState();
}

class _ParentProfileEditScreenState extends State<ParentProfileEditScreen> {
  var formKey = GlobalKey<FormState>();
  // Define the input format
  DateFormat inputFormat = DateFormat('yyyy/MM/dd');
  CoreBloc coreBloc = CoreBloc();
  @override
  Widget build(BuildContext context) {
    log('app constants is same address ${AppConstants.loggedUser?.isSameAddress}');
    return Scaffold(
      appBar: SimpleAppBar(
          title: 'Edit profile',
          iconColor: Colors.black,
          leadingWidget:

              // showDetails
              //     ? GestureDetector(
              //         onTap: () => changeViewMode(),
              //         child: const Padding(
              //           padding: EdgeInsets.all(12.0),
              //           child: Icon(
              //             Icons.arrow_back,
              //             color: Colors.black,
              //           ),
              //         ),
              //       )
              //     :
              GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          )),
      body: Consumer<UserProfileEditController>(
          builder: (context, controller, _) {
        return controller.isEditProfileLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                padding: pagePadding,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ...coreForms(),

                      Consumer<UserProfileEditController>(
                          builder: (context, controller, _) {
                        return Column(
                          children: [
                            TextFieldCustom(
                              // isEnabled: false,
                              labelText: 'Full Name',
                              hintText: 'Full Name',
                              // controller: fullnameController,
                              initialValue:
                                  controller.userDetailsModel?.name ?? '',
                              // initialValue: widget.isAfterLogin ? userDetailsModel?.name : model?.name ?? '',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter full name';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                controller.userDetailsModel?.name = text;
                                // model?.name = text;
                              },
                            ),
                            AppConstants.loggedUser?.role == 'parent'
                                ? Column(
                                    children: [
                                      const Gap(12),
                                      TextFieldCustom(
                                        // isEnabled: false,
                                        labelText: 'Mobile Number',
                                        hintText: 'Mobile Number',
                                        readOnlyField: true,
                                        keyboardType: TextInputType.phone,
                                        // controller: phoneNumberController,
                                        initialValue: controller
                                                .userDetailsModel
                                                ?.phoneNumber ??
                                            '',
                                        // initialValue: widget.isAfterLogin ? userDetailsModel?.phoneNumber :  model?.phoneNumber ?? '',
                                        validator: (value) {
                                          // if (AppConstants.loggedUser?.role ==
                                          //     'student') {
                                          //   return null;
                                          // }
                                          if (value == null || value.isEmpty) {
                                            return 'Enter mobile number';
                                          }
                                          return null;
                                        },
                                        onChanged: (text) {
                                          //model?.phoneNumber = text;
                                        },
                                      ),
                                      const Gap(12),
                                      TextFieldCustom(
                                        labelText: 'Email',
                                        hintText: 'Email',
                                        initialValue: controller
                                                .userDetailsModel?.email ??
                                            '',
                                        onChanged: (text) {
                                          //model?.email = text;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Enter email address';
                                          } else if (!EmailChecker.isValid(
                                              value)) {
                                            return 'Not a valid email format';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const Gap(12),
                            DatePickerTextField(
                              // isEnabled: false,
                              onChanged: (date) {
                                controller.userDetailsModel?.dob =
                                    inputFormat.format(date ?? DateTime.now());
                                // print('dob val : $value'); controller.userDetailsModel?.dob ??
                                // if (value != null) model?.dob = value;
                              },
                              value: inputFormat.parse(
                                  controller.userDetailsModel?.dob ??
                                      inputFormat.format(DateTime.now())),
                              labelText: 'DD-MM-YYYY',
                              hintText: 'DD-MM-YYYY',
                              initialDate: DateTime(DateTime.now().year - 5,
                                  DateTime.now().month, DateTime.now().day),
                              lastDate: DateTime(DateTime.now().year - 5,
                                  DateTime.now().month, DateTime.now().day),
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
                                      controller.onGenderChnage(
                                          genderData: Gender.male);
                                      //controller
                                      // setState(() {
                                      //   gender = Gender.male;
                                      //   model?.gender = gender.name;
                                      // });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff32A337)
                                            .withOpacity(.4),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 48,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Assets.svgs.maleIcon.svg(
                                              height: controller.gender ==
                                                      Gender.male
                                                  ? 22
                                                  : null),
                                          const Gap(12),
                                          Text(
                                            'Male',
                                            style:
                                                controller.gender == Gender.male
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
                                      controller.onGenderChnage(
                                          genderData: Gender.female);
                                      // setState(() {
                                      //   gender = Gender.female;
                                      //   model?.gender = gender.name;
                                      // });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xff1696BB)
                                              .withOpacity(.4),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Assets.svgs.femaleIcon.svg(
                                              height: controller.gender ==
                                                      Gender.female
                                                  ? 22
                                                  : null),
                                          const Gap(12),
                                          Text(
                                            'Female',
                                            style: controller.gender ==
                                                    Gender.female
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
                          ],
                        );
                      }),
                      const Gap(24),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Home address",
                              style: titleLarge.darkBG,
                            ),
                            const Gap(29),
                            TextFieldCustom(
                              // isEnabled: false,
                              validator: (value) {
                                // if (widget.isAfterLogin &&
                                //     AppConstants.loggedUser?.role == 'student') {
                                //   return null;
                                // }
                                if (value == null || value.isEmpty) {
                                  return 'Enter home address';
                                }
                                return null;
                              },
                              hintStyle: labelLarge.copyWith(
                                  color: ColorResources.darkBG),
                              hintText: 'Address',
                              maxLines: 6,
                              minLines: 4,
                              keyboardType: TextInputType.multiline,
                              initialValue:
                                  controller.userDetailsModel?.address ?? '',
                              onChanged: (text) {
                                controller.userDetailsModel?.address = text;
                                //  model?.homeAddress = text;
                              },
                            ),
                            const Gap(16),
                            TextFieldCustom(
                              controller: TextEditingController(
                                  text:
                                      controller.selectedCountry?.title ?? ''),
                              readOnlyField: true,
                              validator: (value) {
                                if (controller.selectedCountry == null) {
                                  return 'Choose a country';
                                }
                                return null;
                              },
                              onTap: () async {
                                final CountryModel? result = //open country list
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomSearchResult<CountryModel>(
                                            title: 'Countries',
                                            search: (p0) {
                                              return controller.coreBloc
                                                  .fetchCountriesList(p0);
                                            },
                                          ),
                                        ));
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (result != null) {
                                  controller.selectedCountryChnage(
                                      selectedCountryData: result);
                                  // selectedCountry = result;
                                  // selectedState = null;
                                  // model?.homeCountryId = result.id;
                                }
                              },
                              // isEnabled: false,
                              labelText: 'Country',
                              suffixWidget: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Assets.svgs.dropdown.svg(),
                              ),
                            ),
                            //if (selectedCountry != null) ...[
                            const Gap(12),
                            TextFieldCustom(
                              // isEnabled: false,
                              validator: (value) {
                                if (controller.selectedState == null) {
                                  return 'Choose a state';
                                }
                                return null;
                              },
                              controller: TextEditingController(
                                  text: controller.selectedState?.title ?? ''),
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
                                                  controller.selectedCountry
                                                          ?.id ??
                                                      0,
                                                  p0);
                                            },
                                          ),
                                        ));
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (result != null) {
                                  controller.selectedStateChnage(
                                      selectedCountryData: result);
                                  // setState(() {
                                  //   // selectedState = result;
                                  //   // model?.homeStateId = result.id;
                                  // });
                                }
                              },
                              readOnlyField: true,
                              labelText: 'State',
                              suffixWidget: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Assets.svgs.dropdown.svg(),
                              ),
                            ),
                            //],
                            const Gap(29),
                            Visibility(
                              visible:
                                  !(AppConstants.loggedUser?.role == 'student'),
                              child: Column(
                                children: [
                                  Text(
                                    'Communication Address',
                                    style: titleLarge.darkBG,
                                  ),
                                  const Gap(31),
                                  CupertinoButton(
                                    minSize: 0,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      controller.isSameAddressSelected();
                                      // setState(() {
                                      //   isSameAddress = !isSameAddress;
                                      //   model?.isSameAddress = isSameAddress;
                                      // });
                                    },
                                    child: Row(
                                      children: [
                                        (controller.isSameAsSelected)
                                            ? Assets.svgs.boxChecked.svg()
                                            : Assets.svgs.mainCheckboxInactive
                                                .svg(),

                                        // Assets.svgs.mainCheckboxInactive.svg(),
                                        const Gap(16),
                                        Text(
                                          'Same as home address',
                                          style: bodyMedium.darkBG,
                                        )
                                      ],
                                    ),
                                  ),
                                  const Gap(29),
                                  if (!(controller.isSameAsSelected)) ...[
                                    TextFieldCustom(
                                      keyboardType: TextInputType.multiline,
                                      hintStyle: labelLarge.copyWith(
                                          color: ColorResources.darkBG),
                                      hintText: 'Address',
                                      // initialValue: model?.communicationAddress ?? '',
                                      onChanged: (text) {
                                        // model?.communicationAddress = text;
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
                                        // final CountryModel? result = //open country list
                                        //     await Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               CustomSearchResult<CountryModel>(
                                        //             title: 'Countries',
                                        //             search: (p0) {
                                        //               return coreBloc.fetchCountriesList(p0);
                                        //             },
                                        //           ),
                                        //         ));
                                        // FocusManager.instance.primaryFocus?.unfocus();
                                        // if (result != null) {
                                        //   setState(() {
                                        //     selectedCommunicationCountry = result;
                                        //     selectedCommunicationState = null;
                                        //     model?.communicationCountryId = result.id;
                                        //   });
                                        //}
                                      },
                                      child: TextFieldCustom(
                                        // initialValue: selectedCommunicationCountry?.title ?? '',
                                        readOnlyField: true,
                                        // controller: TextEditingController(
                                        //     text: selectedCommunicationCountry?.title ?? ''),
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
                                        // isEnabled: false,
                                        labelText: 'Country',
                                        suffixWidget: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Assets.svgs.dropdown.svg(),
                                        ),
                                        validator: (value) {
                                          if (controller.selectedCountry ==
                                              null) {
                                            return 'Choose a country';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const Gap(12),
                                    GestureDetector(
                                      onTap: () async {
                                        // final CountryModel? result = //open state list
                                        //     await Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               CustomSearchResult<CountryModel>(
                                        //             title: 'State',
                                        //             search: (p0) {
                                        //               return coreBloc.fetchStateList(
                                        //                   selectedCountry!.id!, p0);
                                        //             },
                                        //           ),
                                        //         ));
                                        // if (result != null) {
                                        //   setState(() {
                                        //     selectedCommunicationState = result;
                                        //     model?.communicationStateId = result.id;
                                        //   });
                                        // }
                                      },
                                      child: TextFieldCustom(
                                        // controller: TextEditingController(
                                        //     text: selectedCommunicationState?.title ?? ''),
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
                                        // isEnabled: false,
                                        labelText: 'State',
                                        suffixWidget: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Assets.svgs.dropdown.svg(),
                                        ),
                                        validator: (value) {
                                          if (controller.selectedState ==
                                              null) {
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
                          ]),
                      const Gap(32),
                      SubmitButton(
                        'Update',
                        onTap: (loader) async {
                          // loader();

                          if (formKey.currentState?.validate() ?? false) {
                            controller
                                .onEditProfileSubmited(loader: loader)
                                .then((result) {
                              if (result) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen()),
                                  (route) => false,
                                );
                              }
                            });
                          }
                          //   model?.homeCountryId = selectedCountry?.id;
                          //   model?.homeStateId = selectedState?.id;
                          //   if (model?.isSameAddress ?? false) {
                          //     model?.communicationAddress = model?.homeAddress;
                          //     model?.communicationCountryId =
                          //         selectedCountry?.id;
                          //     model?.communicationStateId = selectedState?.id;
                          //   }
                          //   //profile update api call
                          //   setState(() {
                          //     loader();
                          //   });
                          //   final bool result =
                          //       await bloc.updateProfile(model!);
                          //   setState(() {
                          //     loader();
                          //   });

                          //   if (result) {
                          //     Navigator.pushAndRemoveUntil(
                          //       context,
                          //       CupertinoPageRoute(
                          //           builder: (context) =>
                          //               const DashboardScreen()),
                          //       (route) => false,
                          //     );
                          //   }
                          // }
                        },
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
