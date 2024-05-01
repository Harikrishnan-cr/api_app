import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/service_locator.dart';

class KidsDashboardController extends ChangeNotifier {
  bool enableBottomNavBar = true;

  static KidsDashboardController get i => sl<KidsDashboardController>();

  KidsNavBarItem currentTabIndex = KidsNavBarItem.home;

  changeTab(KidsNavBarItem newTab) {
    currentTabIndex = newTab;
    notifyListeners();
  }

  toggleNavBarVisibility() {
    enableBottomNavBar = !enableBottomNavBar;
    notifyListeners();
  }
}

enum KidsNavBarItem {  notification,home, profile }

extension KidsNavAssets on KidsNavBarItem {
  String get name {
    switch (this) {
      case KidsNavBarItem.home:
        return 'Home';
      case KidsNavBarItem.notification:
        return 'Notifications';
      case KidsNavBarItem.profile:
        return 'My Profile';
      default:
        return '';
    }
  }

  SvgPicture get icon {
    switch (this) {
      case KidsNavBarItem.home:
        return Assets.svgs.kids.navHome.svg();
      case KidsNavBarItem.notification:
        return Assets.svgs.kids.navNotification.svg();
      case KidsNavBarItem.profile:
        return Assets.svgs.kids.navProfile.svg();
      default:
        return Assets.svgs.navbar.book.svg();
    }
  }

  SvgPicture get bg {
    switch (this) {
      case KidsNavBarItem.home:
        return Assets.svgs.kids.navHome.svg(fit: BoxFit.fitWidth);
      case KidsNavBarItem.notification:
        return Assets.svgs.kids.navNotification.svg(fit: BoxFit.fitWidth);
      case KidsNavBarItem.profile:
        return Assets.svgs.kids.navProfile.svg(fit: BoxFit.fitWidth);
      default:
        return Assets.svgs.kids.navProfile.svg(fit: BoxFit.fitWidth);
    }
  }
}
