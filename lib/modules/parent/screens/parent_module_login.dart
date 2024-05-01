import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/parent/bloc/user_bloc.dart';

import 'package:samastha/modules/parent/screens/parent_home_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/rect_box_vert_lines.dart';

class ParentModuleSetPassword extends StatefulWidget {
  static const String path = '/parent-module-set-password';
  final bool isResetPassword;

  const ParentModuleSetPassword({super.key, required this.isResetPassword});

  @override
  State<ParentModuleSetPassword> createState() =>
      _ParentModuleSetPasswordState();
}

class _ParentModuleSetPasswordState extends State<ParentModuleSetPassword> {
  bool hidePassword = true;
  bool hideCnfPassword = true;

  UserBloc bloc = UserBloc();

  TextEditingController passwordTc = TextEditingController();
  TextEditingController cnfPasswordTc = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: scrollController,
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
                    // search bar
                    SimpleAppBar(
                      title: 'Parent Module',
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

                    Form(
                      key: formKey,
                      child: Column(
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
                                      : "You are continuing as a parent",
                                  style: headlineMedium.darkBG,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(18),
                                Text(
                                  widget.isResetPassword
                                      ? 'Enter new PIN to continue'
                                      : 'for parental controlling add password for your parent module',
                                  style: bodyMedium.s16.darkBG,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(42),
                                TextFieldCustom(
                                  controller: passwordTc,
                                  obscure: hidePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter PIN';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    // if (scrollController.position.pixels ==
                                    //     scrollController
                                    //         .position.maxScrollExtent) {
                                    if (scrollController.positions.isNotEmpty) {
                                      scrollController.jumpTo(scrollController
                                              .position.maxScrollExtent /
                                          2);
                                    }
                                    // }
                                  },
                                  labelText: 'PIN',
                                  suffix: InkWell(
                                      child: hidePassword
                                          ? Assets.svgs.eyeClosed.svg()
                                          : Assets.svgs.eye
                                              .svg(), //obscure image
                                      onTap: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      }),
                                ),
                                const Gap(16),
                                TextFieldCustom(
                                  onTap: () {
                                    print('asdas');
                                    scrollToBottom();
                                  },
                                  controller: cnfPasswordTc,
                                  obscure: hideCnfPassword,
                                  labelText: 'Confirm PIN',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter confirm PIN';
                                    } else {
                                      return passwordTc.text.trim() ==
                                              value.trim()
                                          ? null
                                          : 'PIN not matching';
                                    }
                                  },
                                  suffix: InkWell(
                                      child: hideCnfPassword
                                          ? Assets.svgs.eyeClosed.svg()
                                          : Assets.svgs.eye
                                              .svg(), //obscure image
                                      onTap: () {
                                        setState(() {
                                          hideCnfPassword = !hideCnfPassword;
                                        });
                                      }),
                                ),
                                const Gap(18),
                                SubmitButton.primary('Continue',
                                    onTap: (loader) async {
                                  scrollToBottom();
                                  try {
                                    if (formKey.currentState!.validate()) {
                                      loader();

                                      final bool result = await bloc
                                          .setPassword(passwordTc.text.trim());

                                      loader();

                                      if (result) {
                                        AppConstants.loggedUser?.role =
                                            'parent';
                                        AuthBloc().setUserToken(
                                            AppConstants.loggedUser!);
                                        Navigator.popAndPushNamed(
                                            context, ParentModuleLogin.path);
                                      }
                                    }
                                  } catch (e) {
                                    loader();
                                  }
                                }),
                                const Gap(40),
                                // Visibility(
                                //   visible: false,
                                //   child: CupertinoButton(
                                //     child: Text(
                                //       'Forgot Pin?',
                                //       style: titleLarge.secondary,
                                //     ),
                                //     onPressed: () {
                                //       Navigator.pushNamed(
                                //           context, ParentHomeScreen.path);
                                //     },
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

  void scrollToBottom() {
    if (scrollController.positions.isNotEmpty)
      scrollController.jumpTo(scrollController.position.maxScrollExtent / 2);
  }
}

class ParentModuleLogin extends StatefulWidget {
  static const String path = '/parent-module-login';

  const ParentModuleLogin({super.key});

  @override
  State<ParentModuleLogin> createState() => _ParentModuleLoginState();
}

class _ParentModuleLoginState extends State<ParentModuleLogin> {
  bool hidePassword = true;

  final UserBloc bloc = UserBloc();

  var passwordTC = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                    // search bar
                    SimpleAppBar(
                      title: 'Parent Module',
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

                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Assets.image.parentalControl2.image(height: 195),
                          Padding(
                            padding: pagePadding,
                            child: Column(
                              children: [
                                const Gap(31),
                                Text(
                                  "You are continuing as a parent",
                                  style: headlineMedium.darkBG,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(18),
                                Text(
                                  'for parental controlling log into parent module with your password',
                                  style: bodyMedium.s16.darkBG,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(42),
                                TextFieldCustom(
                                  focusNode: FocusNode(),
                                  controller: passwordTC,
                                  obscure: hidePassword,
                                  labelText: 'PIN',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter PIN';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () {
                                    if (_scrollviewController
                                        .positions.isNotEmpty) {
                                      _scrollviewController.jumpTo(
                                          _scrollviewController
                                                  .position.maxScrollExtent /
                                              2);
                                    }
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
                                const Gap(18),
                                SubmitButton.primary('Continue',
                                    onTap: (loader) async {
                                  try {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    loader();

                                    final bool result = await bloc
                                        .pinCheck(passwordTC.text.trim());
                                    loader();
                                    if (result) {
                                      Navigator.pushNamed(
                                          context, ParentHomeScreen.path);
                                    }
                                  } catch (e) {
                                    loader();
                                  }
                                }),
                                const Gap(40),
                                CupertinoButton(
                                  child: Text(
                                    'Forgot PIN?',
                                    style: titleLarge.secondary,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ParentModuleSetPassword.path,
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
