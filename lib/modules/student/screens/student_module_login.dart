// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/madrasa/screens/regular_class_screen.dart';

import 'package:samastha/modules/student/bloc/student_controller.dart';
import 'package:samastha/modules/student/models/student_login_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/rect_box_vert_lines.dart';

class StudentModuleSetPassword extends StatefulWidget {
  static const String path = '/student-module-set-password';
  final bool isResetPassword;

  const StudentModuleSetPassword({super.key, required this.isResetPassword});

  @override
  State<StudentModuleSetPassword> createState() =>
      _StudentModuleSetPasswordState();
}

class _StudentModuleSetPasswordState extends State<StudentModuleSetPassword> {
  bool hidePassword = false;
  bool hideCnfPassword = false;

  TextEditingController pinTC = TextEditingController();
  TextEditingController pinCnfTC = TextEditingController();

  bool result = false;

  final _scrollviewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollviewController,
        padding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              const RectBoxWithVertLines(),
              SafeArea(
                top: true,
                child: Column(
                  children: [
                    SimpleAppBar(
                      title: 'Student Module',
                      bgColor: Colors.transparent,
                      textStyle: titleLarge.white,
                      leadingWidget: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(16).copyWith(right: 0),
                            child: Assets.svgs.arrrowBack
                                .svg(color: ColorResources.WHITE),
                          )),
                    ),
                    Column(
                      children: [
                        Assets.image.parentalControl2.image(height: 195),
                        Padding(
                          padding: pagePadding,
                          child: Column(
                            children: [
                              const Gap(31),
                              Text(
                                widget.isResetPassword
                                    ? 'Reset PIN'
                                    : "You are continuing as a student",
                                style: headlineMedium.darkBG,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(18),
                              Text(
                                widget.isResetPassword
                                    ? 'Enter new PIN to continue'
                                    : 'Set a pin to access student dashboard',
                                style: bodyMedium.s16.darkBG,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(42),
                              TextFieldCustom(
                                controller: pinTC,
                                obscure: hidePassword,
                                labelText: 'PIN',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter pin';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  // if (_scrollviewController.position.pixels ==
                                  //     _scrollviewController
                                  //         .position.maxScrollExtent) {
                                  if (_scrollviewController
                                      .positions.isNotEmpty) {
                                    _scrollviewController.jumpTo(
                                        _scrollviewController
                                                .position.maxScrollExtent /
                                            2);
                                  }
                                  // }
                                },
                                suffix: InkWell(
                                    child: hidePassword
                                        ? Assets.svgs.eyeClosed.svg()
                                        : Assets.svgs.eye.svg(),
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    }),
                              ),
                              const Gap(16),
                              TextFieldCustom(
                                controller: pinCnfTC,
                                obscure: hideCnfPassword,
                                labelText: 'Confirm PIN',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter pin';
                                  }
                                  return pinTC.text.trim() == value.trim()
                                      ? null
                                      : 'PIN not matching';
                                },
                                suffix: InkWell(
                                    child: hideCnfPassword
                                        ? Assets.svgs.eyeClosed.svg()
                                        : Assets.svgs.eye.svg(),
                                    onTap: () {
                                      setState(() {
                                        hideCnfPassword = !hideCnfPassword;
                                      });
                                    }),
                              ),
                              const Gap(18),
                              SubmitButton.primary('Continue',
                                  onTap: (loader) async {
                                FocusScope.of(context).unfocus();

                                if (pinCnfTC.text.trim() == pinTC.text.trim()) {
                                  loader();
                                  result = await StudentController()
                                      .setPin(pinTC.text.trim());
                                  loader();
                                  if (result) {
                                    Navigator.popAndPushNamed(
                                        context, StudentModuleLogin.path);
                                  }
                                } else {
                                  SnackBarCustom.success(
                                      'Both pins should be the same');
                                }

                                // Navigator.pushNamed(context,
                                //     OnlineMadrasaRegularClassScreen.path);
                              }),
                              const Gap(40),
                              // Visibility(
                              //   visible: false,
                              //   child: CupertinoButton(
                              //     child: Text(
                              //       'Forgot PIN?',
                              //       style: titleLarge.secondary,
                              //     ),
                              //     onPressed: () {},
                              //   ),
                              // ),
                              const Gap(30),
                              const Gap(40),
                              const Gap(100),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StudentModuleLogin extends StatefulWidget {
  static const String path = '/student-module-login';

  const StudentModuleLogin({super.key});

  @override
  State<StudentModuleLogin> createState() => _StudentModuleLoginState();
}

class _StudentModuleLoginState extends State<StudentModuleLogin> {
  bool hidePassword = true;

  final _pinTC = TextEditingController();
  final _scrollviewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollviewController,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              const RectBoxWithVertLines(),
              SafeArea(
                top: true,
                child: Column(
                  children: [
                    SimpleAppBar(
                      title: 'Student Module',
                      bgColor: Colors.transparent,
                      textStyle: titleLarge.white,
                      leadingWidget: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(16).copyWith(right: 0),
                            child: Assets.svgs.arrrowBack
                                .svg(color: ColorResources.WHITE),
                          )),
                    ),
                    Column(
                      children: [
                        Assets.image.parentalControl2.image(height: 195),
                        Padding(
                          padding: pagePadding,
                          child: Column(
                            children: [
                              const Gap(31),
                              Text(
                                "You are continuing as a student",
                                style: headlineMedium.darkBG,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(18),
                              Text(
                                'Login with student pin to continue',
                                style: bodyMedium.s16.darkBG,
                                textAlign: TextAlign.center,
                              ),
                              const Gap(42),
                              TextFieldCustom(
                                // focusNode: FocusNode(),
                                controller: _pinTC,
                                obscure: hidePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter pin';
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {
                                  // if (_scrollviewController.position.pixels ==
                                  //     _scrollviewController
                                  //         .position.maxScrollExtent) {
                                  if (_scrollviewController
                                      .positions.isNotEmpty) {
                                    _scrollviewController.jumpTo(
                                        _scrollviewController
                                                .position.maxScrollExtent /
                                            2);
                                  }
                                  // }
                                },
                                labelText: 'PIN',
                                suffix: InkWell(
                                    child: hidePassword
                                        ? Assets.svgs.eyeClosed.svg()
                                        : Assets.svgs.eye.svg(),
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    }),
                              ),
                              const Gap(18),
                              SubmitButton.primary('Continue',
                                  onTap: (loader) async {
                                loader();
                                StudentLoginModel? result =
                                    await StudentController()
                                        .login(_pinTC.text.trim());
                                loader();
                                if (result != null) {
                                  Navigator.pushNamed(context,
                                      OnlineMadrasaRegularClassScreen.path,
                                      arguments: {
                                        'studnetId': result.id,
                                        'isParent': false
                                      });
                                }

                                // Navigator.pushNamed(
                                //     context, StudentDashboardScreen.path);
                              }),
                              const Gap(40),
                              CupertinoButton(
                                child: Text(
                                  'Forgot PIN?',
                                  style: titleLarge.secondary,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, StudentModuleSetPassword.path,
                                      arguments: true);
                                },
                              ),
                              const Gap(30),
                              const Gap(40),
                              const Gap(160),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
