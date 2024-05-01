import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_bg.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignments_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exams_list_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quizzes_list_screen.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/double_arrow_list_tile.dart';

class KidsTestAndAssignmentsScreen extends StatelessWidget {
  const KidsTestAndAssignmentsScreen({super.key});
  static const String path = '/kids-test-assignments-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Tests and Assignments'),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const KidsBg(),
          Column(
            children: [
              const Gap(24),
              KidsDoubleArrowListTile(
                title: 'Assignments',
                color: const Color(0xffDBDBFF),
                assetGenImage: Assets.icon.assignments,
                onTap: () => Navigator.pushNamed(
                    AppConstants.globalNavigatorKey.currentContext!,
                    AssignmentsScreen.path),
              ),
              const Gap(16),
              KidsDoubleArrowListTile(
                title: 'Exams',
                color: const Color(0xffFFDBF1),
                assetGenImage: Assets.icon.exams,
                onTap: () => Navigator.pushNamed(
                    AppConstants.globalNavigatorKey.currentContext!,
                    ExamsListScreen.path),
              ),
              const Gap(16),
              KidsDoubleArrowListTile(
                title: 'Quizzes',
                color: const Color(0xffFFFBDB),
                assetGenImage: Assets.icon.quizzes,
                onTap: () => Navigator.pushNamed(
                    AppConstants.globalNavigatorKey.currentContext!,
                    QuizzesListScreen.path,
                    arguments: AppConstants.studentID),
              ),
            ],
          )
        ],
      ),
    );
  }
}
