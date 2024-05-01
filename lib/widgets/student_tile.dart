import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:shimmer/shimmer.dart';

class StudentTile extends StatelessWidget {
  final String className;
  final String name;
  final String admissionNumber;
  final String batch;
  final String? imgUrl;

  const StudentTile({
    super.key,
    required this.className,
    required this.name,
    required this.admissionNumber,
    required this.batch, this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          imgUrl != null
              ? UserAvatar(
                path: imgUrl,
                  size: 85,
                )
              : CircleAvatar(
                  radius: 85 / 2,
                  backgroundColor: ColorResources.PLACEHOLDER,
                  backgroundImage: AssetImage(Assets.image.man.path),
                ),
          const Gap(23),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: titleLarge.darkBG,
              ),
              const Gap(5),
              Text(
                'Admission Number',
                style: labelMedium.darkBG,
              ),
              const Gap(3),
              // Expanded(
              //   child:
              Row(
                children: [
                  Flexible(
                    child: Text(
                      admissionNumber,
                      style: titleMedium.darkBG,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(16),
                  GestureDetector(
                      onTap: () => Clipboard.setData(
                              ClipboardData(text: admissionNumber))
                          .then((value) => SnackBarCustom.success('Copied to clipboard')),
                      child: Assets.icon.copyBlue.image(height: 24)),
                ],
              ),
              // )
              const Gap(2),
              Text(
                'Class $className   Batch $batch',
                style: labelMedium.darkBG,
              )
            ],
          ))
        ],
      ),
    );
  }
}

class StudentTileShimmer extends StatelessWidget {
  final String className;
  final String name;
  final String admissionNumber;

  const StudentTileShimmer({
    super.key,
    required this.className,
    required this.name,
    required this.admissionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 85 / 2,
              backgroundColor: ColorResources.PLACEHOLDER,
              backgroundImage: AssetImage(Assets.image.man.path),
            ),
            const Gap(23),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: titleLarge.darkBG,
                ),
                const Gap(5),
                Text(
                  'Admission Number',
                  style: labelMedium.darkBG,
                ),
                const Gap(3),
                // Expanded(
                //   child:
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        admissionNumber,
                        style: titleMedium.darkBG,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(16),
                    GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: admissionNumber));
                          SnackBarCustom.success('Admission number copied');
                        },
                        child: Assets.icon.copyBlue.image(height: 24))
                  ],
                ),
                // )
                const Gap(2),
                Text(
                  'Class $className   Batch UKSP12',
                  style: labelMedium.darkBG,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
