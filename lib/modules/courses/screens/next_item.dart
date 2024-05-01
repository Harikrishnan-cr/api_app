import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';

class NextItem extends StatelessWidget {
  final Function()? callBack;
  const NextItem({
    super.key,
    this.thumb,
    this.callBack,
  });

  final String? thumb;

  @override
  Widget build(BuildContext context) {
    bool isClickable = callBack != null;
    return Expanded(
      child: GestureDetector(
        onTap: isClickable ? callBack : null,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: const Color(0xffE0E1E2), width: 1)),
          child: Row(children: [
            const Gap(6),
            Text(
              'Next',
              style: isClickable ? titleSmall.darkBG : titleSmall.placeholder,
            ),
            const Gap(10),
            Assets.svgs.doubleArrow.svg(
                height: 9,
                color: isClickable ? null : ColorResources.PLACEHOLDER),
            const Gap(6),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: isClickable
                    ? Image.network(
                        thumb ?? '',
                        // Assets.image.videoBg.path,
                        fit: BoxFit.fitHeight,
                        height: 48,
                      )
                    : Container(
                        color: ColorResources.BORDER_SHADE,
                        height: 48,
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
