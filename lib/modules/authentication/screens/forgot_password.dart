import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/authentication/bloc/auth_bloc.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/country_picker_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String path = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgtrPasswordScreenState();
}

class _ForgtrPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthBloc authBloc = AuthBloc();
  TextEditingController phoneTC = TextEditingController();
  String? dialCode = '91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Forgot Password'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 26),
        child: SubmitButton(
          'Next',
          onTap: (loader) async {
            // Navigator.popAndPushNamed(context, ResetPasswordScreen.path,arguments: '9947132557');
            loader();
            try {
              const bool isOk = true;
              // await authBloc.checkPasswordResetPhoneNumber(phoneTC.text.trim());
              if (isOk) {
                await authBloc.requestTOTP(
                    isResetPassword: true,
                    resetPhoneNo: phoneTC.text.trim(),
                    context,
                    ('+${dialCode!}${phoneTC.text.trim()}'), callback: () {
                  setState(() {
                    print('callback ');  
                    loader(isLoading: false);
                  });
                }).onError((_,__) {
                  print('finished ');
                  loader(isLoading: false);
                }).whenComplete(() {
                  print('when complete ');
                  loader(isLoading: false);
                });
              }
            } catch (e) {
               loader(isLoading: false);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(80),
                Assets.image.lockImage.image(height: 150, width: 108),
                const Gap(32),
                const Text(
                  'Please provide us with your registered\n phone number to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(0, 19, 25, 0.5)),
                ),
                const Gap(30),
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
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
