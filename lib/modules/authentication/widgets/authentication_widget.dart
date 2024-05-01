import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samastha/theme/t_style.dart';

class TermsAndPrivacyWidget extends StatelessWidget {
  const TermsAndPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "By signing up, you agree to our \n",
                children: [
                  TextSpan(
                      text: "Terms and Conditions",
                      style: headlineSmall.secondary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print("T&M")),
                  const TextSpan(text: " and "),
                  TextSpan(
                      text: "Privacy Policy",
                      style: headlineSmall.secondary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print("PP")),
                ],
                style: const TextStyle(color: Colors.black, fontSize: 13)),
          ),
          // gapLarge,
          // gapLarge,
          // Text(
          //   "Not Register?",
          //   style: body1.grey1,
          // ),
          // // TextButton(onPressed: onPressed, child: child)
          // //    Text(
          // //   "Not Register?",
          // //   style: body1.grey1,
          // // ),
          // //  CustomTextButton(
          // //     title: 'Create Account Now',
          // //     buttonclick: () {},
          // //     textStyle: heading1.secondary),
          // CustomTextButton(
          //     title: 'Create Account Now',
          //     buttonclick: () {},
          //     textStyle: heading1.secondary)
        ],
      ),
    );
  }
}

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    super.key,
    required this.backgroundColor,
    required this.borderSide,
    required this.title,
    required this.icon,
    required this.textColor,
  });
  final Color backgroundColor;
  final Color borderSide;
  final Color textColor;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderSide, width: 2),
                borderRadius: BorderRadius.circular(12.0))),
        onPressed: () {},
        icon: SvgPicture.asset(icon),
        label: Text(
          title,
          style: headlineMedium.copyWith(color: textColor),
        ));
  }
}
