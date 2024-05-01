import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/screens/academic_calendar.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/double_arrow_list_tile.dart';

class CoursePlanScreen extends StatelessWidget {
  const CoursePlanScreen({super.key});
  static const String path = '/course-plan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Course Plan'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            //image
            Assets.image.coursePlanBanner.image(
              width: double.infinity,
            ),
            const Gap(17),
            DoubleArrowListTile(
              icon: Assets.image.academicCalendar.image(
                height: 56,
              ),
              title: 'Academic Calendar',
              onTap: () {
                Navigator.pushNamed(context, AcademicCalendar.path);
              },
            ),
          ],
        ),
      )),
    );
  }
}
