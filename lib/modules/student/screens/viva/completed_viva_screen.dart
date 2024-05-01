import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class CompletedVivaScreen extends StatelessWidget {
  const CompletedVivaScreen({
    super.key,
  });

  static const String path = '/completed-viva';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding.copyWith(bottom: 30),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Successfully Completed\nyour Viva',
              style: titleLarge.primary,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              'Your admission procedure has completed',
              style: labelLarge.primary,
              textAlign: TextAlign.center,
            ),
            const Gap(19),
            Text(
              'you can login using your admission number as username and date of birth will be your password',
              style: labelLarge.darkBG,
              textAlign: TextAlign.center,
            ),
            const Gap(34),
            SubmitButton(
              'Go home',
              onTap: (value) {
                if (AppConstants.loggedUser?.role == 'kid') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, KidsDashboardScreen.path, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, DashboardScreen.path, (route) => false);
                }
                // Navigator.pushNamedAndRemoveUntil(
                //     context, DashboardScreen.path, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
