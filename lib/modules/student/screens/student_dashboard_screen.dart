import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/student/screens/leader_board.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/leave_requests_list_screen.dart';
import 'package:samastha/modules/student/screens/live_class_room_welcome_screen.dart';
import 'package:samastha/modules/student/screens/missed_class/missed_classes_screen.dart';
import 'package:samastha/modules/student/screens/missed_class/one_to_one_class.dart';
import 'package:samastha/modules/student/screens/summary_dashboard_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/tests_dashboard.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/rect_box_vert_lines.dart';
import 'package:samastha/widgets/student_tile.dart';
import 'package:samastha/widgets/user_avatar_grid_item.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  static const String path = '/student-dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const RectBoxWithVertLines(),
          SafeArea(
              child: Column(
            children: [
              SimpleAppBar(
                title: 'Kaina Jalil',
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
              PaddedColumn(
                padding: pagePadding,
                children: [
                  const StudentTile(
                      admissionNumber: '123132',
                      className: '2',
                      name: 'Kaina Jalal',
                      batch: 'asd'),
                  const Gap(24),
                  GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // padding:
                      //     pagePadding.copyWith(top: 30, left: 30, right: 30),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                right: 30,
                                top: 20,
                                child: Assets.icon.liveRect.image(height: 12)),
                            UserAvatarGridItem(
                              icon: Assets.icon.classroom.image(height: 80),
                              title: 'Class room',
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LiveClassWelcomeScreen.path);
                              },
                            ),
                          ],
                        ),
                        UserAvatarGridItem(
                          icon: Assets.icon.summary.image(height: 80),
                          title: 'Summarys',
                          onTap: () {
                            Navigator.pushNamed(
                                context, StudentSummaryDashboardScreen.path,
                                arguments: true);
                          },
                        ),
                        UserAvatarGridItem(
                          icon: Assets.icon.leaveRequest.image(height: 80),
                          title: 'Leave Requests',
                          onTap: () {
                            Navigator.pushNamed(
                              AppConstants.globalNavigatorKey.currentContext!,
                              LeaveRequestsListScreen.path,
                            );
                          },
                        ),
                        UserAvatarGridItem(
                          icon: Assets.icon.test.image(height: 80),
                          title: 'Tests & Assignments',
                          onTap: () {
                            Navigator.pushNamed(
                                context, TestsAndAssignmentsDashboard.path);
                          },
                        ),
                        UserAvatarGridItem(
                          icon: Assets.icon.leaderboard.image(height: 100),
                          title: 'Leader Board',
                          onTap: () {
                            Navigator.pushNamed(
                                context, LeaderBoardScreen.path);
                          },
                        ),
                        UserAvatarGridItem(
                          icon: Assets.icon.missedClass.image(height: 80),
                          title: 'Missed Classes',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MissedClassesScreen.path,
                            );
                          },
                        ),
                        // UserAvatarGridItem(
                        //   icon: Assets.icon.dailyTask.image(height: 80),
                        //   title: 'Daily Tasks',
                        // ),
                        UserAvatarGridItem(
                          icon: Assets.icon.ustadCircle.image(height: 95),
                          title: 'One to one class',
                          onTap: () {
                            Navigator.pushNamed(
                                context, OneToOneClassWelcomeScreen.path,
                                arguments: {
                                  "missedClassId": 0,
                                  "subjectId": 0
                                });
                          },
                        ),
                      ]),
                ],
              )
            ],
          ))
        ]),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 84,
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 8),
            color: const Color(0xff000000).withOpacity(.15)),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: ImageViewer(path: imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
