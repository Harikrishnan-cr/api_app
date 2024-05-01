import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/screens/student_dashboard_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/rect_box_vert_lines.dart';

class StudentRegularClassWelcomeScreen extends StatelessWidget {
  const StudentRegularClassWelcomeScreen({super.key});

  static const String path = '/student-regular-class-welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const RectBoxWithVertLines(),
          SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // search bar
                  SimpleAppBar(
                    title: 'Regular Class',
                    bgColor: Colors.transparent,
                    textStyle: titleLarge.white,
                    leadingWidget: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.all(16).copyWith(right: 0),
                          child: Assets.svgs.arrrowBack
                              .svg(color: ColorResources.WHITE),
                        )),
                  ),
// makeIt
                  Column(
                    children: [
                      Assets.image.parentalControl2.image(height: 195),
                      Padding(
                        padding: pagePadding,
                        child: Column(
                          children: [
                            const Gap(31),
                            Text(
                              "You have not registered as a regular student",
                              style: button.darkBG,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(18),
                            Text(
                              'Get admission through parent module',
                              style: bodyMedium.s16.darkBG,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(150),
                            SubmitButton.primary('Get Admission',
                                onTap: (loader) {
                              Navigator.pushNamed(
                                  AppConstants
                                      .globalNavigatorKey.currentContext!,
                                  StudentDashboardScreen.path);
                            }),
                            const Gap(30),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
