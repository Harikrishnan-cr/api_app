import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';

class LiveClassItem extends StatelessWidget {
  const LiveClassItem({
    super.key,
    required this.name,
    required this.id,
    this.title,
    this.duration,
    this.url,
  });

  final String name;
  final int id;
  final String? title;
  final String? duration;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: defaultDecoration,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 97,
                // height: 96,
                constraints: const BoxConstraints(minHeight: 96),
                color: Colors.purpleAccent,
                child: Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: ColorResources.primary),
                    child: const Icon(
                      Icons.play_arrow,
                      color: ColorResources.WHITE,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: titleSmall.grey1,
                  ),
                  const Gap(8),
                  Text(
                    title ?? '',
                    style: bodyMedium.darkBG,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        duration ?? '00:00',
                        style: labelMedium.secondary,
                      ),
                      const Spacer(),
                      // Assets.svgs.circleDownload.svg()
                      Assets.icon.liveRect.image(height: 12),
                      const Gap(12)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
