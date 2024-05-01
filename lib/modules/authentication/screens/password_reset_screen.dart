import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/authentication/screens/login_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.username});
  static const path = '/reset-password';
  final String? username;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  AuthBloc authBloc = AuthBloc();
  final _paswwordController = TextEditingController();
  final _confirmPaswwordController = TextEditingController();
  bool resetSuccess = false;
  bool hidePassword = true;
  bool hidePasswordCnf = true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: SimpleAppBar(title: resetSuccess ? '' : 'Reset Password'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 26),
        child: SubmitButton(
          resetSuccess ? 'Login' : 'Next',
          onTap: (loader) {
            if (_paswwordController.text.trim() ==
                _confirmPaswwordController.text.trim()) {
              loader();
              if (resetSuccess) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              } else {
                authBloc
                    .changePassword(
                        widget.username ?? '',
                        _paswwordController.text,
                        _confirmPaswwordController.text)
                    .then((value) {
                  loader(isLoading: false);
                  setState(() {
                    resetSuccess = value?.status ?? false;
                  });
                });
              }
              loader(isLoading: false);

              // Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => OTPScreen(
              //             verificationId: 'verificationId',
              //             phoneNumber: 'phoneNumber',
              //             resendToken: 'resendToken',isResetPassword: true),
              //       ));
            } else {
              showErrorMessage('Passwords must be same');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Center(
            child: resetSuccess
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(54),
                      Row(
                      
                        children: [
                          Assets.image.doneTick.image(height: 212, width: 248),
                        ],
                      ),
                      const Gap(24),
                      const Text(
                        'Your password has been reset\n successfully !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(0, 19, 25, 0.5)),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(80),
                      Assets.image.lockImage.image(height: 150, width: 108),
                      const Gap(30),
                      TextFieldCustom(
                        controller: _paswwordController,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Password can not be empty';
                          }

                          return null;
                        },
                        hintText: 'Password',
                        labelText: 'Password',
                        obscure: hidePassword,
                        maxLines: 1,
                        suffix: InkWell(
                            child: hidePassword ? Assets.svgs.eyeClosed.svg() :  Assets.svgs.eye.svg(),
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            }),
                      ),
                      const Gap(30),
                      TextFieldCustom(
                        controller: _confirmPaswwordController,
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        obscure: hidePasswordCnf,
                        maxLines: 1,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Confirm password can not be empty';
                          }
                          // if (passwordTC.text.trim() !=
                          //     passwordCnfTC.text.trim()) {
                          //       return 'Passwords must be same';
                          //   // return 'Password and confirm password\n should be equal';
                          // }
                          return null;
                        },
                        suffix: InkWell(
                            child: hidePasswordCnf ? Assets.svgs.eyeClosed.svg() :  Assets.svgs.eye.svg(),
                            onTap: () {
                              setState(() {
                                hidePasswordCnf = !hidePasswordCnf;
                              });
                            }),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
