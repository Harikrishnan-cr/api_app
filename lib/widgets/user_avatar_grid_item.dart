import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/theme/t_style.dart';

class UserAvatarGridItem extends StatelessWidget {
  const UserAvatarGridItem({
    super.key,
    this.onTap,
    this.title,
    required this.icon, this.mainAxisAlignment,
  });
  final Function()? onTap;
  final String? title;
  final Widget icon;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          icon,
          const Gap(14),
          Text(
            title ?? '',
            style: titleSmall.darkBG,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
