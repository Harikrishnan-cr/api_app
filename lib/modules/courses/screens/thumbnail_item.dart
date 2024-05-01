import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/video_local_storage.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/parent/controller/get_local_videos_controller.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/alert_box_widgets.dart';

class ThumbnailItem extends StatelessWidget {
  final Function()? callback;
  const ThumbnailItem({
    super.key,
    required this.sharkImage,
    required this.time,
    this.callback,
    required this.title,
    this.onTap,
  });

  final String sharkImage;
  final String time;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: defaultDecoration,
        child: Row(
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      sharkImage,
                      fit: BoxFit.fitHeight,
                      height: 91,
                    ),
                    SizedBox(
                        height: 91,
                        width: double.infinity,
                        child: ImageViewer(path: sharkImage, height: 91)),
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white70,
                        child: Assets.svgs.videoPlay
                            .svg(color: const Color(0xff20AB84)))
                  ],
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: bodyMedium.grey1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      Text(
                        'Play Now',
                        style: titleMedium.copyWith(
                            color: const Color(0xff20AB84)),
                      ),
                      const Gap(4),
                      Expanded(flex: 1, child: Assets.svgs.timer.svg()),
                      // const Gap(4),
                      Expanded(
                        flex: 3,
                        child: Text(
                          time,
                          style: labelMedium.copyWith(
                              color: const Color(0xffA5B07D)),
                          maxLines: 1,
                        ),
                      )
                      // const Spacer(),
                      // Assets.svgs.timer.svg(),
                      // // const Gap(4),
                      // Text(
                      //   time,
                      //   style: labelMedium.copyWith(
                      //       color: const Color(0xffA5B07D)),
                      //   maxLines: 1,
                      // )
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

class LocalVideoThumb extends StatelessWidget {
  final Function()? callback;
  const LocalVideoThumb(
      {super.key,
      this.sharkImage,
      required this.time,
      this.callback,
      required this.materialId,
      required this.title,
      this.onTap,
      this.deleteUrlFilePath});

  final Uint8List? sharkImage;
  final String time;
  final String title;
  final int materialId;
  final void Function()? onTap;

  final File? deleteUrlFilePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: defaultDecoration,
            child: Row(
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 91,
                          width: 100,
                          child: sharkImage == null
                              ? Image.asset(
                                  'assets/image/quran.png',
                                  fit: BoxFit.cover,
                                  height: 91,
                                )
                              : Image.memory(
                                  sharkImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        // SizedBox(
                        //     height: 91,
                        //     width: double.infinity,
                        //     child: ImageViewer(path: sharkImage, height: 91)),
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white70,
                            child: Assets.svgs.videoPlay
                                .svg(color: const Color(0xff20AB84)))
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        title,
                        style: bodyMedium.grey1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(30),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Assets.svgs.timer.svg(),
                                  const Gap(4),
                                  Text(
                                    time,
                                    style: labelMedium.copyWith(
                                        color: const Color(0xffA5B07D)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Play Now',
                                    style: titleMedium.copyWith(
                                        color: const Color(0xff20AB84)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // const Spacer(),

                      // Assets.svgs.timer.svg(),
                      // const Gap(4),
                      // Text(
                      //   time,
                      //   style: labelMedium.copyWith(
                      //       color: const Color(0xffA5B07D)),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: SizedBox(
              width: 60,
              height: 60,
              child: CupertinoButton(
                  minSize: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AlertBoxWidgets.deleteLocalVideo(
                      'Delete Video ?',
                      'Are you sure that you want to delete this video ? This process \ncan’t be undone',
                      'Delete',
                      context,
                      dleteFileLocal: deleteUrlFilePath,
                      materialID: materialId,
                      onTap: (loader) async {
                        log('material id is $materialId');
                        // await VideoDownlaodLocalClass.deleteLocalVidoe(
                        //         materialId)
                        //     .whenComplete(() {
                        //   Provider.of<GetLocalVideoController>(context,
                        //           listen: false)
                        //       .getLoaclVideos();
                        //   Navigator.pop(context);
                        // });

                        // var response = await bloc.deleteAccount();
                        // showErrorMessage(response.message ?? '');

                        // if (response.status ?? false) {
                        //   AuthBloc().logout();
                        // }
                      },
                    );
                  },
                  child: SvgPicture.asset('assets/image/delete_svg_image.svg')),
            ),
          )
        ],
      ),
    );
  }
}
