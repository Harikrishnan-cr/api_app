import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/custom_form_elements.dart';

class StudentBeyondAgeScreen extends StatelessWidget {
  const StudentBeyondAgeScreen({
    super.key,
  });

  static const String path = '/student-beyond-age';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            const Spacer(),
            Center(child: Assets.image.handDown.image(height: 171)),
            const Spacer(),
            Text(
              'Sorry',
              style: headlineMedium.darkBG,
            ),
            const Gap(13),
            Text(
              'student is beyond the age limit',
              style: titleLarge.darkBG,
            ),
            const Spacer(),
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
