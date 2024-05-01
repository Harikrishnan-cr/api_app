import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/app_route.dart';
import 'package:samastha/core/cloud_messgage_notifier.dart';
import 'package:samastha/core/update_fcm.dart';
import 'package:samastha/modules/dashboard/screens/my_profile_screen.dart';
import 'package:samastha/modules/kids/modules/dashboard/controller/kids_dashboard_controller.dart';
import 'package:samastha/modules/kids/modules/home/screen/kids_home_screen.dart';
import 'package:samastha/modules/notification/screens/notification_list_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/widgets/alert_box_widgets.dart';

class KidsDashboardScreen extends StatefulWidget {
  static const String path = '/kids-dashboard';

  const KidsDashboardScreen({super.key});

  @override
  State<KidsDashboardScreen> createState() => _KidsDashboardScreenState();
}

class _KidsDashboardScreenState extends State<KidsDashboardScreen> {
  KidsDashboardController bloc = KidsDashboardController.i;

  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    CloudMessagingService.initialize(FirebaseMessaging.instance);

    Provider.of<FcmTokenProvider>(context, listen: false).init();
    super.initState();

    _pages = [
      Navigator(
        key: AppConstants.kidsNotificationNavigatorKey,
        initialRoute: NotificationListScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
      Navigator(
        key: AppConstants.kidsHomeNavigatorKey,
        initialRoute: KidsHomeScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
      Navigator(
        key: AppConstants.kidsProfileNavigatorKey,
        initialRoute: MyProfileScreen.path,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    ];
    bloc.currentTabIndex = KidsNavBarItem.home;
    _pageController = PageController(initialPage: bloc.currentTabIndex.index);
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
                    children: _pages,
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
                              ColorResources.WHITE,
                              ColorResources.WHITE,
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
                              children: KidsNavBarItem.values
                                  .map(
                                    (e) => Expanded(
                                      child: GestureDetector(
                                        onTap: () {
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
