import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/madrasa/screens/class_room_screen.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/student_login_model.dart';
import 'package:samastha/modules/student/models/student_profile_model.dart';
import 'package:samastha/modules/student/screens/leader_board.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/leave_requests_list_screen.dart';
import 'package:samastha/modules/student/screens/missed_class/missed_classes_screen.dart';
import 'package:samastha/modules/student/screens/missed_class/one_to_one_class.dart';
import 'package:samastha/modules/student/screens/summary_dashboard_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/tests_dashboard.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/student_tile.dart';
import 'package:samastha/widgets/user_avatar_grid_item.dart';

class OnlineMadrasaRegularClassScreen extends StatefulWidget {
  OnlineMadrasaRegularClassScreen(
      {super.key, this.isParent = false, this.studnetId});
  static const String path = '/madrasa-dashboard';
  bool isParent;

  int? studnetId = 0;

  @override
  State<OnlineMadrasaRegularClassScreen> createState() =>
      _OnlineMadrasaRegularClassScreenState();
}

class _OnlineMadrasaRegularClassScreenState
    extends State<OnlineMadrasaRegularClassScreen> {
  late Future<StudentProfileModel> future;

  AdmissionBloc bloc = AdmissionBloc();
  StudentProfileModel? studentDetails;
  void onAddLocalStorage() async {
    final box = GetStorage();

    await box.write(AppConstants.isParentLogedIn, widget.isParent);
    await box.write(AppConstants.studenIdLocalName, widget.studnetId ?? 0);
  }

  @override
  void initState() {
    onAddLocalStorage();
    if (widget.isParent) {
      future = bloc.fetchProfileparentLogin(widget.studnetId ?? 0);

      return;
    }

    future = bloc.fetchProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('is-- parent ${widget.isParent}');
    log('is-- stdID ${widget.studnetId}');
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'Regular class',
        isShowBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          children: [
            FutureBuilder<StudentProfileModel>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return errorReload(snapshot.error.toString(), onTap: () {
                      if (widget.isParent) {
                        setState(() {
                          future = bloc
                              .fetchProfileparentLogin(widget.studnetId ?? 0);
                        });

                        return;
                      }
                      setState(() {
                        future = bloc.fetchProfile();
                      });
                    });
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const StudentTileShimmer(
                          className: "asdasd",
                          name: "asdaadsa asdasdadadasd",
                          admissionNumber: 'asdasdasdasdasd');

                    case ConnectionState.active:
                    case ConnectionState.done:
                      print('snapshot.data?.image  ${snapshot.data?.image}');
                      studentDetails = snapshot.data;
                      return StudentTile(
                        admissionNumber: snapshot.data?.admissionNo ?? "",
                        className: snapshot.data?.className ?? "",
                        name: snapshot.data?.name ?? "",
                        batch: snapshot.data?.batchName ?? '',
                        imgUrl: snapshot.data?.image,
                      );
                    default:
                      return Container();
                  }
                }),
            const Gap(24),
            GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                children: [
                  Container(
                    decoration: defaultDecoration,
                    child: UserAvatarGridItem(
                      mainAxisAlignment: MainAxisAlignment.center, //end
                      icon: Assets.icon.classroom.image(height: 80),
                      title: 'Classroom',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ClassRoomScreen.path,
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: defaultDecoration,
                    child: UserAvatarGridItem(
                      mainAxisAlignment: MainAxisAlignment.center, //end
                      icon: Assets.icon.summary.image(height: 80),
                      title: 'My Summary',
                      onTap: () {
                        Navigator.pushNamed(
                            AppConstants.globalNavigatorKey.currentContext!,
                            StudentSummaryDashboardScreen.path,
                            arguments: true);
                      },
                    ),
                  ),
                  Container(
                    decoration: defaultDecoration,
                    child: UserAvatarGridItem(
                      mainAxisAlignment: MainAxisAlignment.center, //end
                      icon: Assets.icon.leaveRequest.image(height: 80),
                      title: 'Leave Requests',
                      onTap: () {
                        AppConstants.studentID = studentDetails?.id;
                        Navigator.pushNamed(
                            AppConstants.globalNavigatorKey.currentContext!,
                            LeaveRequestsListScreen.path);
                      },
                    ),
                  ),
                  Container(
                    decoration: defaultDecoration,
                    child: UserAvatarGridItem(
                      mainAxisAlignment: MainAxisAlignment.center, //end
                      icon: Assets.icon.test.image(height: 80),
                      title: 'Tests & Assignments',
                      onTap: () {
                        Navigator.pushNamed(
                            AppConstants.globalNavigatorKey.currentContext!,
                            TestsAndAssignmentsDashboard.path,
                            arguments: studentDetails?.id);
                      },
                    ),
                  ),
                  Container(
                    decoration: defaultDecoration,
                    child: UserAvatarGridItem(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      icon: Assets.icon.leaderboard.image(height: 100),
                      title: 'Leader Board',
                      onTap: () {
                        Navigator.pushNamed(
                            AppConstants.globalNavigatorKey.currentContext!,
                            LeaderBoardScreen.path);
                      },
                    ),
                  ),
                  Container(
                    decoration: defaultDecoration,
                    child: UserAvatarGridItem(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      icon:
                          Assets.icon.missedClass.image(height: 100, width: 80),
                      title: 'Missed Classes',
                      onTap: () {
                        Navigator.pushNamed(
                            AppConstants.globalNavigatorKey.currentContext!,
                            MissedClassesScreen.path,
                            arguments: studentDetails?.id);
                      },
                    ),
                  ),
                ]),
            const Gap(16),
            Visibility(
              visible: false,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      AppConstants.globalNavigatorKey.currentState!.context,
                      OneToOneClassWelcomeScreen.path,
                      arguments: {"missedClassId": 0, "subjectId": 0});
                },
                child: Container(
                  decoration: defaultDecoration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Row(
                    children: [
                      Assets.icon.ustadCircle.image(height: 60),
                      const Gap(14),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'One to one class',
                            style: titleMedium.secondary,
                          ),
                          const Gap(1),
                          Text(
                            'Request one to one class for your kid',
                            style: labelMedium.darkBG,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
