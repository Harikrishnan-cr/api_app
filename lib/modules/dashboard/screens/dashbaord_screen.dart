import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/app_route.dart';
import 'package:samastha/core/cloud_messgage_notifier.dart';
import 'package:samastha/core/update_fcm.dart';
import 'package:samastha/modules/dashboard/controller/dashboard_controller.dart';
import 'package:samastha/modules/dashboard/screens/home_screen.dart';
import 'package:samastha/modules/dashboard/screens/my_courses_screen.dart';
import 'package:samastha/modules/dashboard/screens/my_profile_screen.dart';
import 'package:samastha/modules/notification/screens/notification_list_screen.dart';
import 'package:samastha/modules/student/screens/summary_dashboard_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/alert_box_widgets.dart';

class DashboardScreen extends StatefulWidget {
  static const String path = '/dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController bloc = DashboardController.i;

  late List<Widget> _pages;
  late List<Widget> _pagesTwo;
  late PageController _pageController;

  @override
  void initState() {
    CloudMessagingService.initialize(FirebaseMessaging.instance);

    Provider.of<FcmTokenProvider>(context, listen: false).init();
    super.initState();

    _pages = [
      Navigator(
        key: AppConstants.coursesNavigatorKey,
        initialRoute: MyCoursesScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
      Navigator(
        key: AppConstants.summaryNavigatorKey,
        initialRoute: StudentSummaryDashboardScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
      Navigator(
        key: AppConstants.homeNavigatorKey,
        initialRoute: HomeScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
      Navigator(
        key: AppConstants.notificationNavigatorKey,
        initialRoute: NotificationListScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
      Navigator(
        key: AppConstants.profileNavigatorKey,
        initialRoute: MyProfileScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    ];

    _pagesTwo = [
      MyCoursesScreen(),
      StudentSummaryDashboardScreen(),
      HomeScreen(),
      NotificationListScreen(),
      MyProfileScreen(),
      // Navigator(
      //   key: AppConstants.coursesNavigatorKey,
      //   initialRoute: MyCoursesScreen.path,
      //   onGenerateRoute: Routes.onGenerateRoute,
      // ),
      // Navigator(
      //   key: AppConstants.summaryNavigatorKey,
      //   initialRoute: StudentSummaryDashboardScreen.path,
      //   onGenerateRoute: Routes.onGenerateRoute,
      // ),
      // Navigator(
      //   key: AppConstants.homeNavigatorKey,
      //   initialRoute: HomeScreen.path,
      //   onGenerateRoute: Routes.onGenerateRoute,
      // ),
      // Navigator(
      //   key: AppConstants.notificationNavigatorKey,
      //   initialRoute: NotificationListScreen.path,
      //   onGenerateRoute: Routes.onGenerateRoute,
      // ),
      // Navigator(
      //   key: AppConstants.profileNavigatorKey,
      //   initialRoute: MyProfileScreen.path,
      //   onGenerateRoute: Routes.onGenerateRoute,
      // ),
    ];
    bloc.currentTabIndex = NavBarItem.home;
    _pageController = PageController(initialPage: bloc.currentTabIndex.index);
    _pageController.addListener(() {
      log('ssssssssssss ${_pageController.page.toString()}');
    });
    //show welcome note
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AlertBoxWidgets.welcomeNote(context);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        } else {
          // Navigator.pop(context);
        }
      },
      // onWillPop: () {
      //   return context.  Future.value(false);
      // },
      child: AnimatedBuilder(
          animation: bloc,
          builder: (context, child) {
            return Scaffold(
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: ModalRoute.of(context)?.settings.name == null
                        ? _pagesTwo
                        : _pages,
                    onPageChanged: (value) {
                      log('on changed ${ModalRoute.of(context)?.settings.name}'); //    log('on changed  ss ${AppConstants.globalNavigatorKey.currentContext}');
                    },
                  ),
                  if (bloc.enableBottomNavBar)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.loose,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxHeight: 91),
                            alignment: Alignment.bottomCenter,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                              ColorResources.gradientNavEnd,
                              ColorResources.gradientNavStart,
                            ])),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: bloc.currentTabIndex.bg,
                          ),
                          SizedBox(
                            height: 91,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: NavBarItem.values
                                  .map(
                                    (e) => Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (e.index == 1) {
                                            log('role of is ${AppConstants.loggedUser?.role}');
                                            if (AppConstants.loggedUser?.role ==
                                                "parent") {
                                              showErrorMessage(
                                                  'Please login as student');
                                              return;
                                            }
                                          }
                                          bloc.changeTab(e);
                                          _pageController.jumpToPage(e.index);
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            );
          }),
    );
  }
}
