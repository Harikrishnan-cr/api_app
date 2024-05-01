// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/authentication/model/login_response.dart';
import 'package:samastha/modules/authentication/screens/forgot_password.dart';
import 'package:samastha/modules/authentication/screens/register_screen.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/modules/parent/screens/profile_edit_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class LoginScreen extends StatefulWidget {
  static String path = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

  var passwordTC = TextEditingController();
  var userNameTC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log('current screen height is ${MediaQuery.of(context).size.height}');
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        alignment: Alignment.center,
        // fit: StackFit.expand,
        children: [
          //image
          Assets.svgs.bg.svg(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(10 + kToolbarHeight),
                  Assets.image.logoLandscape
                      .image(color: Colors.white, height: 43),
                  const Gap(10),
                  Image.asset(
                    Assets.image.loginImageCrop.path,
                    fit: BoxFit.fitWidth,
                    height: (MediaQuery.of(context).size.height > 800)
                        ? (MediaQuery.of(context).size.height / 2) - 70
                        : (MediaQuery.of(context).size.height * 0.3),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              56,
                            ),
                            topRight: Radius.circular(56))),
                    child: Column(
                      children: [
                        const Gap(5 / 2),
                        Text(
                          "Login",
                          style: displayLarge.darkBG,
                        ),
                        const Gap(3 / 2),
                        Text(
                          'with Samastha E-Learning',
                          style: bodyMedium.darkBG,
                        ),
                        Padding(
                          padding: pagePadding.copyWith(bottom: 0, top: 10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFieldCustom(
                                  labelText: 'User Name / Mobile number',
                                  hintText: 'User Name / Mobile number',
                                  controller: userNameTC,
                                  validator: (value) {
                                    if (value?.trim().isEmpty ?? false) {
                                      return 'Enter username/phone';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(12),
                                TextFieldCustom(
                                  controller: passwordTC,
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  obscure: hidePassword,
                                  validator: (value) {
                                    if (value?.trim().isEmpty ?? false) {
                                      return 'Enter password';
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
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
                                const Gap(24 / 2),
                                //login sec
                                SubmitButton.primary(
                                  'Login',
                                  onTap: (val) async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      setState(() {
                                        val();
                                      });

                                      final LoginResponse? result =
                                          await AuthBloc().login(
                                              userNameTC.text.trim(),
                                              passwordTC.text.trim());

                                      setState(() {
                                        val();
                                      });
                                      if (result != null) {
                                        if (result.otp != null) {
                                          if (AppConstants.loggedUser?.role ==
                                              'kid') {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                KidsDashboardScreen.path,
                                                (route) => false);
                                          } else {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                DashboardScreen.path,
                                                (route) => false);
                                          }
                                        } else {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              ProfileEditScreen.path,
                                              (route) => false);
                                        }
                                      }
                                    }
                                  },
                                ),
                                const Gap(24 / 4),
                                CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ForgotPasswordScreen.path);
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: bodyMedium.darkBG,
                                    )),
                                const Gap(7 / 3),
                                Text(
                                  'New to Samastha E-Learning?',
                                  style: bodyMedium.darkBG,
                                ),
                                GestureDetector(
                                  // padding: EdgeInsets.zero,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RegisterScreen.path);
                                  },
                                  child: Text(
                                    'Create Account',
                                    style: titleLarge.secondary,
                                  ),
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(8)
                ]),
          ),
        ],
      ),
    );
  }
}
