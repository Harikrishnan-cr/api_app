import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';

class VideoClassItem extends StatelessWidget {
  const VideoClassItem({
    super.key,
    required this.name,
    required this.id,
    this.description,
    this.duration,
    required this.isDownloaded,
    this.onDownloadPressed,
    required this.isPurchased, this.imageUrl,
  });

  final String name;
  final int id;
  final String? description;
  final String? duration;
  final bool isDownloaded;
  final bool isPurchased;
  final String? imageUrl;
  final void Function()? onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    log('imageUrl: ${imageUrl}');
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: isPurchased ? defaultDecoration : defaultDecoration.copyWith(
              boxShadow: [],
              color: const Color.fromRGBO(1, 1, 1, 0.2),
            ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SignedImageLoader(
                  path: imageUrl,
                  imageBuilder: (image, loading) {
                    print('video thumbnl ${image}');
                    return Container(
                    width: 97,
                    // height: 96,
                    constraints: const BoxConstraints(minHeight: 96),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: image ?? AssetImage(Assets.image.videoBg.path),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorResources.primary),
                        child: const Icon(
                          Icons.play_arrow,
                          color: ColorResources.WHITE,
                          size: 16,
                        ),
                      ),
                    ),
                  );
                  },
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(8),
                    Text(
                      description ?? '',
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
                        GestureDetector(
                            onTap: isPurchased ? onDownloadPressed : null,
                            child: isDownloaded
                                ? Assets.image.blueTick.image()
                                : Assets.svgs.circleDownload.svg())
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (!isPurchased)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icon.courseLock.image(color: Colors.white, height: 36)
            ],
          )
      ],
    );
  }
}
