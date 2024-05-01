import 'package:flutter/material.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSize {
  const SimpleAppBar(
      {super.key,
      required this.title,
      this.bottom,
      this.trailing,
      this.bgColor,
      this.textStyle,
      this.leadingWidget,
      this.flexibleSpace,
      this.iconColor,
      this.isShowBackButton = true});
  final String title;
  final PreferredSize? bottom;
  final List<Widget>? trailing;
  final Color? bgColor;
  final TextStyle? textStyle;
  final Widget? leadingWidget;
  final Widget? flexibleSpace;
  final Color? iconColor;
  final bool? isShowBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      title: Text(
        title,
        style: textStyle ?? titleLarge.darkBG,
      ),
      flexibleSpace: flexibleSpace,
      titleSpacing: 9,
      backgroundColor: bgColor ?? ColorResources.WHITE,
      automaticallyImplyLeading: false,
      // leadingWidth: Navigator.of(context).canPop() ? kToolbarHeight : 10,
      actions: trailing,
      leading: leadingWidget ??
          (Navigator.of(context).canPop()
              ? (isShowBackButton!
                  ? InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(16).copyWith(right: 0),
                        child: Assets.svgs.arrrowBack
                            .svg(color: iconColor ?? ColorResources.darkBG),
                      ))
                  : const SizedBox())
              : Container()),
      bottom: bottom,
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize =>
      Size.fromHeight(56 + (bottom?.preferredSize.height ?? 0.0));
}
