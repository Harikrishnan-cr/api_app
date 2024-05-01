import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/dashboard/controller/home_controller.dart';
import 'package:samastha/modules/dashboard/models/banner_model.dart';
import 'package:samastha/modules/dashboard/widgets/home_carousal.dart';
import 'package:samastha/modules/dashboard/widgets/home_search_bar.dart';
import 'package:samastha/modules/parent/screens/applications_screen.dart';
import 'package:samastha/modules/parent/screens/my_kids_list_screen.dart';
import 'package:samastha/modules/student/screens/join_higher_class_welcome_screen.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/leave_requests_list_screen.dart';
import 'package:samastha/modules/student/screens/new_join_registration_form.dart';
import 'package:samastha/modules/student/screens/tests_assignments/tests_dashboard.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/ongoing_live_class.dart';
import 'package:samastha/widgets/rect_box_vert_lines.dart';
import 'package:samastha/widgets/user_avatar_grid_item.dart';

class ParentHomeScreen extends StatelessWidget {
  static const String path = '/parent-dashboard';
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              //image
              const RectBoxWithVertLines(height: 173),
              SafeArea(
                top: true,
                child: SingleChildScrollView(
                  padding: pagePadding,
                  child: Column(
                    children: [
                      // search bar
                      // const HomeSearchBar(),
                      // const Gap(16),

                      // HomeCarousal(image: [
                      //   Assets.image.onlineQuranBanner.image(),
                      //   Assets.image.onlineQuranBanner.image(),
                      //   Assets.image.onlineQuranBanner.image(),
                      //   Assets.image.onlineQuranBanner.image(),
                      //   Assets.image.onlineQuranBanner.image(),
                      // ]),
                      const Gap(16),
                      FutureBuilder<List<BannerModel>>(
                        future: HomeController().fetchBanners(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('could not load the banners!');
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.done:
                              return HomeCarousal(
                                image: List.generate(
                                  snapshot.data!.length,
                                  (index) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: snapshot.data![index].image == null
                                          ? null
                                          : ImageViewer(
                                              path: snapshot
                                                      .data![index].imageUrl ??
                                                  "",
                                              fit: BoxFit.cover,
                                              height: 142,
                                            )),
                                ),
                              );

                            default:
                              return Container();
                          }
                        },
                      ),

                      const Gap(18),
                      SubmitButton(
                        'Get Admission',
                        onTap: (loader) {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              child: SizedBox(
                                height: 172,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.popAndPushNamed(context,
                                              NewJoinRegistrationForm.path);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Assets.svgs.joinFirst.svg(),
                                            const Gap(14),
                                            Text(
                                              'Admission to\nFirst standard',
                                              style: bodyMedium.darkBG,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.popAndPushNamed(
                                              context,
                                              JoinHigherClassWelcomeScreen
                                                  .path);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Assets.svgs.joinHigher.svg(),
                                            const Gap(14),
                                            Text(
                                              'Join to\nHigher class',
                                              style: bodyMedium.darkBG,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const Gap(24),
                      Row(children: [
                        Expanded(
                            child: UserAvatarGridItem(
                          icon: Assets.image.mykids.image(height: 147),
                          onTap: () {
                            Navigator.pushNamed(
                                AppConstants.globalNavigatorKey.currentContext!,
                                MyKidsListScreen.path);
                          },
                          title: 'My Kids',
                        )),
                        Expanded(
                            child: UserAvatarGridItem(
                          icon: Assets.image.application.image(height: 147),
                          onTap: () {
                            Navigator.pushNamed(
                                AppConstants.globalNavigatorKey.currentContext!,
                                MyApplicationsScreen.path);
                          },
                          title: 'My Applications',
                        )),
                      ]),
                      const Gap(24),
                      Visibility(
                        visible: false,
                        child: Row(children: [
                          Expanded(
                              child: UserAvatarGridItem(
                            icon: Assets.image.leave.image(height: 147),
                            onTap: () {
                              Navigator.pushNamed(
                                  AppConstants
                                      .globalNavigatorKey.currentContext!,
                                  LeaveRequestsListScreen.path);
                            },
                            title: 'Leave Requests',
                          )),
                          Expanded(
                              child: UserAvatarGridItem(
                            icon: Assets.image.test.image(height: 147),
                            onTap: () {
                              Navigator.pushNamed(
                                  AppConstants
                                      .globalNavigatorKey.currentContext!,
                                  TestsAndAssignmentsDashboard.path);
                            },
                            title: 'Tests & Assignments',
                          )),
                        ]),
                      ),
                      const Gap(24),
                      //  const OngoingLiveClass(),

                      const Gap(24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
