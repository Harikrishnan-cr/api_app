import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/modules/student/screens/mcq/mcq_welcome_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class ApplicationCompletedScreen extends StatelessWidget {
  static const String path = '/application-success';
  const ApplicationCompletedScreen({super.key, required this.model});

  final StudentRegisterModel model;

  @override
  Widget build(BuildContext context) {
    debugPrint('isFistStd ${model.isFirstStd != 1}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: pagePadding.copyWith(bottom: 40),
        child: Column(
          children: [
            const Spacer(),
            Center(child: Assets.image.successCircle.image(height: 240)),
            Text(
              'Your payment has been completed',
              style: titleLarge.primary,
              textAlign: TextAlign.center,
            ),
            const Gap(9),
            Text(
              'Application Number: ${model.applicationNumber ?? ""}',
              style: labelMedium.darkBG,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Visibility(
              visible: !(model.isFirstStd != 1),
              child: SubmitButton(
                'Go back',
                onTap: (value) {
                  Navigator.pop(context);
                },
              ),
            ),
            Visibility(
              visible:
                  model.isFirstStd != 1, //change as per the class 1 student
              child: Column(
                children: [
                  Text(
                    'To complete the admission process Kindly attend MCQ and VIVA',
                    style: titleSmall.darkBG,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(28),
                  CustomOutlineButton(
                    'Skip Now',
                    onTap: (value) {
                      Navigator.pop(context);
                    },
                  ),
                  const Gap(16),
                  SubmitButton(
                    'Attend MCQ Test Now',
                    onTap: (value) {
                      Navigator.pushNamed(
                        context,
                        MCQWelcomeScreen.path,
                        arguments: model.fkUserId,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
