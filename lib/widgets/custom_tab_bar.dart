import 'package:flutter/material.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.controller,
      required this.tabs,
      this.labelColor,
      this.labelStyle,
      this.indicatorColor,
      this.unselectedLabelColor,
      this.unselectedLabelStyle,
      this.bgColor,
      this.coloredTabBar = false, this.onTap});
  final TabController controller;
  final List<String> tabs;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final Color? indicatorColor;
  final Color? unselectedLabelColor;
  final TextStyle? unselectedLabelStyle;
  final Color? bgColor;
  final bool coloredTabBar;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        onTap: onTap,
        automaticIndicatorColorAdjustment: true,
        controller: controller,
        labelColor: labelColor ?? ColorResources.black,
        labelStyle: labelStyle ?? bodyMedium.black,
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: indicatorColor ?? ColorResources.primary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 1,
        unselectedLabelColor: unselectedLabelColor ?? ColorResources.darkBG,
        unselectedLabelStyle: unselectedLabelStyle ?? labelMedium.darkBG,
        isScrollable: true,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.only(right: 24),
        tabs: tabs
            .map((e) => Tab(
                  text: e,
                ))
            .toList(),
      ),
    );
  }
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar, {super.key});

  @override
  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: tabBar,
      );
}
