// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/type_checker.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/authentication/model/user_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/country_picker_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  static const String path = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hidePassword = true;
  bool hidePasswordCnf = true;

  var passwordTC = TextEditingController();
  var emailTC = TextEditingController();
  var phoneTC = TextEditingController();
  var passwordCnfTC = TextEditingController();

  bool isAccepted = false;

  var formKey = GlobalKey<FormState>();

  String? dialCode = '91';

  AuthBloc bloc = AuthBloc.i;

  bool? isValidated;

  @override
  Widget build(BuildContext context) {
    print('validated ${(isValidated ?? false)} : $isAccepted');
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
                  const Gap(kToolbarHeight),
                  Assets.image.logoLandscape.image(
                    color: Colors.white,
                    height: 43,
                  ),
                  // AspectRatio(
                  //   aspectRatio: 280 / 240,
                  //   child:
                  Assets.image.loginImageCrop
                      .image(height: 280, fit: BoxFit.cover),
                  // ),
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
                        const Gap(22),
                        Text(
                          "Create Account",
                          style: displayLarge.darkBG.copyWith(fontSize: 41),
                        ),
                        const Gap(3),
                        Text(
                          'with Samastha E-Learning',
                          style: bodyMedium.darkBG,
                        ),
                        Padding(
                          padding: pagePadding.copyWith(bottom: 10, top: 10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFieldCustom(
                                  labelText: 'Email Id',
                                  hintText: 'Email Id',
                                  controller: emailTC,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      return 'Email can not be empty';
                                    }
                                    if (EmailChecker.isValid(value!) == false) {
                                      return 'Not a valid email format';
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(12),
                                TextFieldCustom(
                                  labelText: 'Mobile number',
                                  hintText: 'Mobile number',
                                  controller: phoneTC,
                                  keyboardType: TextInputType.phone,
                                  maxLines: 1,
                                  minLines: 1,
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      return 'Phone can not be empty';
                                    }

                                    return null;
                                  },
                                  prefix: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: CountryCodePickerView(
                                      onNewCountryTap: (newCode) {
                                        setState(() {
                                          dialCode = newCode;
                                        });
                                      },
                                      initialDialCode: dialCode,
                                    ),
                                  ),
                                ),
                                const Gap(12),
                                TextFieldCustom(
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      return 'Password can not be empty';
                                    }

                                    return null;
                                  },
                                  controller: passwordTC,
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  obscure: hidePassword,
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
                                const Gap(12),
                                TextFieldCustom(
                                  controller: passwordCnfTC,
                                  hintText: 'Confirm Password',
                                  labelText: 'Confirm Password',
                                  obscure: hidePasswordCnf,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value?.isEmpty ?? false) {
                                      return 'Confirm password can not be empty';
                                    }
                                    if (passwordTC.text.trim() !=
                                        passwordCnfTC.text.trim()) {
                                      return 'Passwords must be same';
                                      // return 'Password and confirm password\n should be equal';
                                    }
                                    return null;
                                  },
                                  suffix: InkWell(
                                      child: hidePasswordCnf
                                          ? Assets.svgs.eyeClosed.svg()
                                          : Assets.svgs.eye.svg(),
                                      onTap: () {
                                        setState(() {
                                          hidePasswordCnf = !hidePasswordCnf;
                                        });
                                      }),
                                ),
                                const Gap(16),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAccepted = !isAccepted;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      isAccepted
                                          ? Assets.svgs.boxChecked.svg()
                                          : Icon(
                                              Icons.check_box_outline_blank,
                                              color: (isValidated ?? true)
                                                  ? Colors.black
                                                  : Colors.red,
                                            ),
                                      const Gap(19),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            style: bodyMedium.copyWith(
                                              color: ColorResources.darkBG,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text:
                                                    'By signing up, you agree to our ',
                                              ),
                                              TextSpan(
                                                text: 'Terms & Conditions ',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        try {
                                                          final url = Uri.parse(
                                                              'https://course.samasthaelearning.com/terms-and-conditions');
                                                          if (await canLaunchUrl(
                                                              url)) {
                                                            await launchUrl(
                                                                url);
                                                          } else {
                                                            SnackBarCustom.success(
                                                                'Failed to load terms and conditions');
                                                          }
                                                        } catch (e) {
                                                          SnackBarCustom.success(
                                                              'Failed to load terms and conditions');
                                                        }
                                                      },
                                                style: bodyMedium.copyWith(
                                                  color:
                                                      ColorResources.secondary,
                                                ),
                                              ),
                                              const TextSpan(text: 'and '),
                                              TextSpan(
                                                text: 'Privacy Policy',
                                                style: bodyMedium.secondary,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        try {
                                                          final url = Uri.parse(
                                                              'https://course.samasthaelearning.com/terms-and-conditions');
                                                          if (await canLaunchUrl(
                                                              url)) {
                                                            await launchUrl(
                                                                url);
                                                          } else {
                                                            SnackBarCustom.success(
                                                                'Failed to load Privacy Policy');
                                                          }
                                                        } catch (e) {
                                                          SnackBarCustom.success(
                                                              'Failed to load Privacy Policy');
                                                        }
                                                      },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(12),
                                SubmitButton.primary(
                                  'Create Account',
                                  onTap: (loader) async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      setState(() {
                                        isValidated = isAccepted ? true : false;
                                      });
                                      if (!isAccepted) {
                                        Flushbar(
                                          message:
                                              "Agree terms and privacy policy to continue",
                                          duration: const Duration(seconds: 3),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          flushbarStyle: FlushbarStyle.GROUNDED,
                                        ).show(context);
                                        return;
                                      }
                                      FocusScope.of(context).unfocus();
                                      //check phone number
                                      setState(() {
                                        loader();
                                      });
                                      final bool isOk =
                                          await bloc.checkPhoneNumber(
                                              phoneTC.text.trim());
                                      //send OTP

                                      if (isOk) {
                                        bloc.registerModel = UserModel(
                                            email: emailTC.text.trim(),
                                            countryCode: dialCode,
                                            mobile: phoneTC.text.trim(),
                                            password: passwordTC.text.trim());
                                        await bloc.requestTOTP(context,
                                            ('+${dialCode!}${phoneTC.text.trim()}'),
                                            callback: () {
                                          setState(() {
                                            loader(isLoading: false);
                                          });
                                        });
                                        setState(() {
                                          loader(isLoading: false);
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        loader();
                                        isValidated = false;
                                      });
                                      Flushbar(
                                        message: "Enter all fields",
                                        duration: const Duration(seconds: 3),
                                        flushbarStyle: FlushbarStyle.GROUNDED,
                                      ).show(context);
                                    }
                                    setState(() {
                                      loader(isLoading: false);
                                    });
                                  },
                                ),
                                const Gap(12),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: bodyMedium.copyWith(
                                      color: ColorResources.darkBG,
                                    ),
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: 'Already registered? '),
                                      TextSpan(
                                        text: 'Login',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pop(context);
                                          },
                                        style: titleLarge.copyWith(
                                          color: ColorResources.secondary,
                                        ),
                                      ),
                                    ],
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
