import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/screens/chat/chart_with_usthad.dart';
import 'package:samastha/modules/student/screens/course_plan_screen.dart';
import 'package:samastha/modules/student/screens/fee_payment_summary.dart';
import 'package:samastha/modules/student/screens/performance_analysys_dashboard.dart';
import 'package:samastha/modules/student/screens/usthads_list_screen.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/double_arrow_list_tile.dart';

class StudentSummaryDashboardScreen extends StatelessWidget {
  const StudentSummaryDashboardScreen({super.key, this.isShowBack});
  static const String path = '/student-summary';
  final bool? isShowBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (isShowBack ?? false)
          ? const SimpleAppBar(title: 'Student Summary')
          : const SimpleAppBar(
              title: 'Student Summary',
              leadingWidget: Icon(
                Icons.arrow_back,
                color: Colors.transparent,
              )),
      body: ListView(
        padding: pagePadding,
        children: [
          DoubleArrowListTile(
            icon: Assets.image.lessonPlan.image(
              height: 56,
            ),
            title: 'Lesson Plan',
            onTap: () {
              Navigator.pushNamed(
                  AppConstants.globalNavigatorKey.currentContext!,
                  CoursePlanScreen.path);
            },
          ),
          DoubleArrowListTile(
            icon: Assets.image.performanceAnalysy.image(
              height: 56,
            ),
            title: 'Performance Analysis',
            onTap: () {
              Navigator.pushNamed(
                  AppConstants.globalNavigatorKey.currentContext!,
                  PerformanceAnalysisDashboard.path);
            },
          ),
          DoubleArrowListTile(
            icon: Assets.image.chatWithUstad.image(
              height: 56,
            ),
            title: 'Chat With Usthad',
            onTap: () {
              Navigator.pushNamed(
                  AppConstants.globalNavigatorKey.currentContext!,
                  ChatWithUsthad.path);
            },
          ),
          DoubleArrowListTile(
            icon: Assets.image.ustadDetails.image(
              height: 56,
            ),
            title: 'Usthad Details',
            onTap: () {
              Navigator.pushNamed(
                  AppConstants.globalNavigatorKey.currentContext!,
                  UsthadsListScreen.path);
            },
          ),
          Visibility(
            visible: !(1 == 1),
            child: DoubleArrowListTile(
              icon: Assets.image.feePaymentSummary.image(
                height: 56,
              ),
              title: 'Fee Payment Summary',
              onTap: () {
                Navigator.pushNamed(
                    AppConstants.globalNavigatorKey.currentContext!,
                    FeePaymentSummary.path,
                    arguments: 'Fee Payment Summary');
              },
            ),
          ),
        ],
      ),
    );
  }
}
