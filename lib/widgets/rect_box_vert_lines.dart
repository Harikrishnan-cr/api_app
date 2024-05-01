import 'package:flutter/cupertino.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';

class RectBoxWithVertLines extends StatelessWidget {
  const RectBoxWithVertLines({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 197,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        gradient: LinearGradient(colors: [
          ColorResources.gradientNavEnd,
          ColorResources.gradientNavStart,
        ]),
      ),
      child: ClipRRect(
          child: Assets.svgs.rectVertLines
              .svg(fit: BoxFit.cover, width: double.infinity)),
    );
  }
}
