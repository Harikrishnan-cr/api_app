import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/service_locator.dart';

class DashboardController extends ChangeNotifier {
  bool enableBottomNavBar = true;

  static DashboardController get i => sl<DashboardController>();

  NavBarItem currentTabIndex = NavBarItem.home;

  changeTab(NavBarItem newTab) {
    currentTabIndex = newTab;
    notifyListeners();
  }

  toggleNavBarVisibility() {
    enableBottomNavBar = !enableBottomNavBar;
    notifyListeners();
  }
}

enum NavBarItem { courses, summary, home, notification, profile }

extension NavAssets on NavBarItem {
  String get name {
    switch (this) {
      case NavBarItem.courses:
        return 'Courses';
      case NavBarItem.summary:
        return 'Summary';
      case NavBarItem.home:
        return 'Home';
      case NavBarItem.notification:
        return 'Notifications';
      case NavBarItem.profile:
        return 'My Profile';
      default:
        return '';
    }
  }

  SvgPicture get icon {
    switch (this) {
      case NavBarItem.courses:
        return Assets.svgs.navbar.book.svg();
      case NavBarItem.summary:
        return Assets.svgs.navbar.summary.svg();
      case NavBarItem.home:
        return Assets.svgs.navbar.home.svg();
      case NavBarItem.notification:
        return Assets.svgs.navbar.notification.svg();
      case NavBarItem.profile:
        return Assets.svgs.navbar.profile.svg();
      default:
        return Assets.svgs.navbar.book.svg();
    }
  }

  SvgPicture get bg {
    switch (this) {
      case NavBarItem.courses:
        return Assets.svgs.navbar.courseFull.svg(fit: BoxFit.fitWidth);
      case NavBarItem.summary:
        return Assets.svgs.navbar.summaryFull.svg(fit: BoxFit.fitWidth);
      case NavBarItem.home:
        return Assets.svgs.navbar.homeFull.svg(fit: BoxFit.fitWidth);
      case NavBarItem.notification:
        return Assets.svgs.navbar.notificationInactiveFull
            .svg(fit: BoxFit.fitWidth);
      case NavBarItem.profile:
        return Assets.svgs.navbar.myProfileFull.svg(fit: BoxFit.fitWidth);
      default:
        return Assets.svgs.navbar.myProfileFull.svg(fit: BoxFit.fitWidth);
    }
  }
}
