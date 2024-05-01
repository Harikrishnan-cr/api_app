import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';

class DoubleArrowListTile extends StatelessWidget {
  const DoubleArrowListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final Widget icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: defaultDecoration,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            icon,
            const Gap(16),
            Text(
              title,
              style: titleSmall.darkBG,
            ),
            const Spacer(),
            Assets.svgs.doubleArrow.svg()
          ],
        ),
      ),
    );
  }
}

class KidsDoubleArrowListTile extends StatelessWidget {
  const KidsDoubleArrowListTile({
    super.key,
    required this.title,
    this.onTap, this.color, required this.assetGenImage,
  });
  final String title;
  final Color? color;
  final Function()? onTap;
  final AssetGenImage assetGenImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 88,
              decoration: ShapeDecoration(
                  color: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(61))),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(14),
                assetGenImage.image(height: 65, width: 65),
                const Gap(16),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF001319),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const Spacer(),
                Assets.svgs.doubleArrow.svg(),
                const Gap(30),
              ],
            )
          ],
        ),
      ),
    );
  }
}
