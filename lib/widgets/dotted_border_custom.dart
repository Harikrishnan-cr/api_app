import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:samastha/theme/color_resources.dart';

class DottedBorderCustom extends StatelessWidget {
  const DottedBorderCustom({
    super.key,
    required this.child,
    this.dashPattern,
    this.onTap, this.color
  });

  final Widget child;
  final List<double>? dashPattern;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          color: color ?? ColorResources.secondary,
          dashPattern: dashPattern ?? [3, 1],
          child: child),
    );
  }
}
