import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/modules/authentication/screens/password_reset_screen.dart';
import 'package:samastha/modules/parent/screens/profile_edit_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPScreen extends StatefulWidget {
  static const path = '/otp';

  final String phoneNumber;
  final resendToken;
  final bool? isResetPassword;
  final String? resetPhoneNo;

  const OTPScreen(
      {super.key,
      required this.verificationId,
      required this.phoneNumber,
      required this.resendToken,
      this.isResetPassword,
      this.resetPhoneNo});
  final String verificationId;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpTC = TextEditingController();

  AuthBloc bloc = AuthBloc.i;

  bool showResendButton = false;

  int seconds = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      appBar: const SimpleAppBar(title: "Verify OTP"),
      body: SafeArea(
        child: Padding(
          padding: pagePadding.copyWith(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gap(91 - 24),
              const Spacer(),
              Text(
                'Enter OTP',
                style: headlineMedium.darkBG,
                textAlign: TextAlign.center,
              ),
              const Gap(4),
              Text(
                'OTP has been sent to your phone number',
                style: bodyMedium.darkBG,
              ),
              const Gap(44),
              Pinput(
                  controller: otpTC,
                  length: 6,
                  defaultPinTheme: PinTheme(
                      height: 55,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            width: 2,
                            color: ColorResources.textFiledBorder,
                          ))),
                  // androidSmsAutofillMethod:
                  //     AndroidSmsAutofillMethod.smsUserConsentApi,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  keyboardType: TextInputType.phone,
                  onSubmitted: (value) =>
                      _verifyOtp(value, widget.isResetPassword ?? false)),
              // Gap(145),
              const Spacer(),
              showResendButton
                  ? CupertinoButton(
                      onPressed: () {
                        setState(() {
                          showResendButton = false;
                          seconds = 60;
                        });
                        otpTC.clear();
                        bloc.requestTOTP(
                          context,
                          widget.phoneNumber,
                          // prevToken: widget.resendToken,
                        );
                      },
                      child: Text(
                        'Resend OTP',
                        style: labelLarge.darkBG,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resend OTP in ',
                          style: labelLarge.darkBG,
                        ),
                        Countdown(
                          seconds: seconds,
                          build: (BuildContext context, double time) => Text(
                            // '00:10 Sec',
                            '${formatHHMMSS(time.toInt())} Sec',
                            style: titleMedium.secondary,
                          ),
                          interval: const Duration(seconds: 1),
                          onFinished: () {
                            setState(() {
                              seconds = 0;
                              showResendButton = true;
                            });
                          },
                        ),
                      ],
                    ),
              // Gap(147),
              const Spacer(),
              CupertinoButton(
                  child: Text(
                    'Change Phone Number?',
                    style: titleSmall.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              // Gap(105),
              const Spacer(),
              SubmitButton(
                'Verify OTP',
                onTap: (value) async {
                  value();

                  await _verifyOtp(otpTC.text, widget.isResetPassword ?? false);
                  value();
                },
              ),

              // const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Future _verifyOtp(String value, bool isResetPassword) async {
    if (value.isEmpty || value.length < 6) {
      SnackBarCustom.success('Not a valid OTP given');
    } else {
      try {
        UserCredential? cred =
            await bloc.verifyOTP(widget.verificationId, value);
        if (cred != null) {
          if (isResetPassword) {
            Navigator.popAndPushNamed(context, ResetPasswordScreen.path,
                arguments: widget.resetPhoneNo);
          } else {
            //call register API
            final bool result = await bloc.register();
            if (result) {
              AppConstants.tempRegisterModel = bloc.registerModel;
              Navigator.pushNamedAndRemoveUntil(
                  context, ProfileEditScreen.path, (route) => false);
            }
          }
        }
      } catch (e) {
        SnackBarCustom.success(e.toString());
      }
    }
  }
}
