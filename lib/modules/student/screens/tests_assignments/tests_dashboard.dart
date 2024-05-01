import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignments_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exams_list_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quizzes_list_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/double_arrow_list_tile.dart';

class TestsAndAssignmentsDashboard extends StatelessWidget {
  const TestsAndAssignmentsDashboard({super.key});
  static const String path = '/test-assignment-dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Tests & Assignments'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            DoubleArrowListTile(
              icon: Assets.icon.assignments.image(
                height: 56,
              ),
              title: 'Assignments',
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final routeArgs1 =
                      ModalRoute.of(context)!.settings.arguments! as int;
                  AppConstants.studentID = routeArgs1;
                  Navigator.pushNamed(
                    context,
                    AssignmentsScreen.path,
                  );
                });
              },
            ),
            DoubleArrowListTile(
              icon: Assets.icon.exams.image(
                height: 56,
              ),
              title: 'Exams',
              onTap: () {
                final routeArgs1 =
                    ModalRoute.of(context)!.settings.arguments! as int;
                AppConstants.studentID = routeArgs1;
                Navigator.pushNamed(context, ExamsListScreen.path);
              },
            ),
            DoubleArrowListTile(
              icon: Assets.icon.quizzes.image(
                height: 56,
              ),
              title: 'Quizzes',
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final routeArgs1 =
                      ModalRoute.of(context)!.settings.arguments! as int;
                  AppConstants.studentID = routeArgs1;
                  Navigator.pushNamed(context, QuizzesListScreen.path,
                      arguments: AppConstants.studentID);
                });
              },
            ),
          ],
        ),
      )),
    );
  }
}
