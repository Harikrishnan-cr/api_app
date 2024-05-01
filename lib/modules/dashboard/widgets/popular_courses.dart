// import 'dart:typed_data';
// import 'dart:ui' as ui;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/screens/course_detail_screen.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';

class CoursesWidget extends StatelessWidget {
  const CoursesWidget({
    super.key,
    required this.title,
    required this.listModel,
    this.isSeeAll = false,
  });
  final String title;
  final List<CourseModel> listModel;
  final bool isSeeAll;

  // Future<DecorationImage> takeImageFromWidget(BuildContext widContext) async {
  //   RenderRepaintBoundary boundary =
  //       widContext.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image =
  //       await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio as needed
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData!.buffer.asUint8List();

  //   DecorationImage customImage = DecorationImage(
  //     image: MemoryImage(pngBytes),
  //     fit: BoxFit.cover,
  //   );
  //   return customImage;
  // }

  List<Widget> buildCourseWidgets(BuildContext context, bool isSeeAll) =>
      listModel
          .map((e) => GestureDetector(
                onTap: () {
                  log('payment status is ${e.paidStatus}');
                  Navigator.pushNamed(context, CourseDetailScreen.path,
                      arguments: {
                        'id': e.id,
                        'name': e.title,
                        'isPurchased': e.paidStatus
                      });
                },
                child: SignedImageLoader(
                  //todo
                  path: e.photoUrl,
                  imageBuilder: (image, loading) {
                    return Container(
                      height: isSeeAll ? 210 : 282,
                      width: isSeeAll ? 325 : 282,
                      margin: EdgeInsets.only(
                          right: isSeeAll ? 0 : 20, bottom: isSeeAll ? 25 : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        image: DecorationImage(
                          image: image ?? AssetImage(Assets.image.makka.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xffD1F5FF).withOpacity(0),
                                  e.id!.isEven
                                      ? const Color(0xffDFFFCC)
                                      : const Color(0xffD4F4FF),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title ?? "",
                                  style: titleSmall.secondary,
                                ),
                                const Gap(4),
                                Text(
                                  e.description ?? "",
                                  style: bodyMedium.darkBG,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(4),
                                Row(
                                  children: [
                                    Text(
                                      '${AppConstants.rupeeSign} ${e.price ?? 0}',
                                      style: titleLarge.primary,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Assets.svgs.clock.svg(),
                                        const Gap(5),
                                        Text(
                                          e.courseDuration ?? '',
                                          style: titleSmall.secondary,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isSeeAll)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleMedium.black,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      AppConstants.globalNavigatorKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) => SeelAllCourseWidget(
                            title: title, listModel: listModel),
                      ));
                },
                child: Text(
                  "See All",
                  style: bodyMedium.primary,
                ),
              )
            ],
          ),
        const Gap(12),
        // comming soon changes ==================================================================================
        1 != 1
            ? Assets.image.kids.comingsoonPoster.image(
                height: isSeeAll ? 335 : 282,
                width: isSeeAll ? 335 : 358,
              )
            : SingleChildScrollView(
                scrollDirection: isSeeAll ? Axis.vertical : Axis.horizontal,
                child: isSeeAll
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildCourseWidgets(context, isSeeAll),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: buildCourseWidgets(context, isSeeAll),
                      ),
              )
      ],
    );
  }
}

class SeelAllCourseWidget extends StatelessWidget {
  const SeelAllCourseWidget(
      {super.key, required this.title, required this.listModel});
  final String title;
  final List<CourseModel> listModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: title,
        // bottom: PreferredSize(
        //     preferredSize: AppBar().preferredSize,
        //     child: child)
      ),
      body: SingleChildScrollView(
        child:
            // Column(
            //   children: [
            //     ListView.builder(
            //                       padding: pagePadding,
            //                       itemCount: listModel.length,
            //                       itemBuilder: (context, index) => MyCourseWidget(
            //                         name: listModel[index].title ?? '',
            //                         title: listModel[index].title ?? '',
            //                         id: listModel[index].id!,
            //                         description: listModel[index].description ?? '',
            //                         progress:  0,
            //                         imgUrl: listModel[index].image,
            //                       ),
            //                     ),
            //   ],
            // ),

            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CoursesWidget(
                title: '',
                listModel: listModel,
                isSeeAll: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
