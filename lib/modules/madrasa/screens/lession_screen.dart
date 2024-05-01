import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';

import 'package:samastha/core/video_local_storage.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/courses/screens/audio_class_item.dart';
import 'package:samastha/modules/courses/screens/course_detail_screen.dart';
import 'package:samastha/modules/courses/screens/notes_class_item.dart';
import 'package:samastha/modules/courses/screens/video_player_screen.dart';
import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
import 'package:samastha/modules/madrasa/controller/video_download_controller.dart';
import 'package:samastha/modules/parent/screens/local_flic_video_payer.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class SubjectLessonWidget extends StatefulWidget {
  final int? subjectId;
  final int? batchId;
  final String? title;
  final String? description;

  const SubjectLessonWidget(
      {super.key, this.subjectId, this.batchId, this.title, this.description});

  @override
  State<SubjectLessonWidget> createState() => _SubjectLessonWidgetState();
}

class _SubjectLessonWidgetState extends State<SubjectLessonWidget> {
  late Future<List<LessonMediaModel>> lessonFuture;

  LessonItem pageView = LessonItem.values[0];

  onPageViewChange(LessonItem newItem) {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      setState(() {
        pageView = newItem;
        lessonFuture = bloc.fetchLessonsParrent(
            widget.subjectId, widget.batchId, pageView.type());
      });

      return;
    }

    setState(() {
      pageView = newItem;
      lessonFuture =
          bloc.fetchLessons(widget.subjectId, widget.batchId, pageView.type());
    });
  }

  MadrasaController bloc = MadrasaController();

  @override
  void initState() {
    if (IsParentLogedInDetails.isParentLogedIn()) {
      lessonFuture = bloc.fetchLessonsParrent(
          widget.subjectId, widget.batchId, pageView.type());

      return;
    }
    lessonFuture =
        bloc.fetchLessons(widget.subjectId, widget.batchId, pageView.type());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // lessonFuture =
    //     bloc.fetchLessons(widget.subjectId, widget.batchId, pageView.type());
    return Container(
      width: double.infinity,
      decoration: defaultDecoration,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? '',
            style: titleLarge.darkBG,
          ),
          const Gap(16),
          Text(
            widget.description ?? '',
            style: bodyMedium.grey1,
          ),
          const Gap(16),
          //header
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < LessonItem.values.length - 1; i++)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                        onTap: () {
                          onPageViewChange(LessonItem.values[i]);
                        },
                        child: Text(
                          LessonItem.values[i].name(),
                          style: pageView == LessonItem.values[i]
                              ? titleSmall.darkBG
                              : labelMedium.darkBG,
                        )),
                  )
              ],
            ),
          ),
          //body
          const Gap(10),
          FutureBuilder<List<LessonMediaModel>>(
              future: lessonFuture,
              builder: (context, subjectsSnapshot) {
                if (subjectsSnapshot.hasError) {
                  return errorReload(subjectsSnapshot.error.toString(),
                      onTap: () {
                    if (IsParentLogedInDetails.isParentLogedIn()) {
                      setState(() {
                        lessonFuture = bloc.fetchLessonsParrent(
                            widget.subjectId, widget.batchId, pageView.type());
                      });

                      return;
                    }
                    setState(() {
                      lessonFuture = bloc.fetchLessons(
                          widget.subjectId, widget.batchId, pageView.type());
                    });
                  });
                }
                switch (subjectsSnapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const LoadingWidget();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    List<LessonMediaModel> data = subjectsSnapshot.data ?? [];
                    return pageBodyBuilder(data);
                  default:
                    return Container();
                }
              }),
        ],
      ),
    );
  }

  Widget pageBodyBuilder(List<LessonMediaModel> lessons) {
    switch (pageView) {
      case LessonItem.videoClass:
        return lessons.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _Item(
                  icon: Assets.svgs.courseVideo.svg(),
                  name: 'Currently there are no video\n classes to show',
                  textStyle: titleLarge.darkBG.copyWith(fontSize: 15),
                  onClick: null,
                ),
              ))
            : Column(
                children: lessons
                    .map(
                      (e) => Consumer<VideoDownloadController>(
                          builder: (context, controller, _) {
                        return GestureDetector(
                          onTap: () {
                            log('role is ${AppConstants.loggedUser?.role}');

                            if (AppConstants.loggedUser?.role?.toLowerCase() ==
                                "kid".toLowerCase()) {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => LocalVideoPlayerScreen(
                              //           currentIndex: lessons.indexOf(e),
                              //           videoUrlLocalPath: lessons.first.url,
                              //         )));
                              Navigator.pushNamed(
                                  AppConstants
                                      .globalNavigatorKey.currentContext!,
                                  VideoPlayerScreen.path,
                                  arguments: {
                                    "lessons": lessons,
                                    "currentIndex": lessons.indexOf(e)
                                  });
                            } else {
                              Navigator.pushNamed(
                                  context, VideoPlayerScreen.path, arguments: {
                                "lessons": lessons,
                                "currentIndex": lessons.indexOf(e)
                              });
                            }
                            // Navigator.pushNamed(context, VideoPlayerScreen.path,
                            //     arguments: {
                            //       "lessons": lessons,
                            //       "currentIndex": lessons.indexOf(e)
                            //     });

                            // Navigator.pushNamed(
                            //     AppConstants.globalNavigatorKey.currentContext!,
                            //     VideoPlayerScreen.path,
                            //     arguments: {
                            //       "lessons": lessons,
                            //       "currentIndex": lessons.indexOf(e)
                            //     });
                          },
                          child: (e.isDownloadStarted ?? false)
                              ? Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    height: 80.0,
                                    width: double.infinity,
                                    // width: 200.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorResources.primary,
                                          Colors.green
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CircularProgressIndicator(
                                            color: ColorResources.PLACEHOLDER,
                                          ),
                                          // SizedBox(
                                          //   height: 20.0,
                                          // ),
                                          Text(
                                            "Downloading File: ${controller.progressString}",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : _VideoClassItem(
                                  name: e.title ?? "",
                                  description: e.description ?? "",
                                  id: e.id!,
                                  thumbnailUrl: e.thumbnailUrl ?? '',
                                  url: e.url,
                                  duration: e.videoDuration,
                                  isDownloaded:
                                      e.downloadedStatus == 'downloaded',
                                  onDownloadPressed: () async {
                                    if (e.downloadedStatus != 'downloaded') {
                                      await controller
                                          .downloadFile(e.url ?? '', e)
                                          .whenComplete(() {
                                        bloc.saveSubject(e.id!).then((value) {
                                          if (IsParentLogedInDetails
                                              .isParentLogedIn()) {
                                            setState(() {
                                              lessonFuture =
                                                  bloc.fetchLessonsParrent(
                                                      widget.subjectId,
                                                      widget.batchId,
                                                      pageView.type());
                                            });

                                            return;
                                          }
                                          setState(() {
                                            lessonFuture = bloc.fetchLessons(
                                                widget.subjectId,
                                                widget.batchId,
                                                pageView.type());
                                          });
                                        });
                                      });

                                      SnackBarCustom.success(
                                          'video downloaded successfully');
                                    } else {
                                      final data = await VideoDownlaodLocalClass
                                          .getAllLocalVidoeFiles();

                                      log('data is ${data?.first.title}');
                                      SnackBarCustom.success(
                                          'The video is already downloaded');
                                    }

                                    // log('on downlaod pressed');
                                    // setState(() {
                                    //   e.isDownloadStarted = true;
                                    // });

                                    // Future.delayed(
                                    //         const Duration(milliseconds: 5000))
                                    //     .whenComplete(() {
                                    //   setState(() {
                                    //     e.isDownloadStarted = false;
                                    //   });
                                    // });
                                    //                               Future<void> downloadFile() async {
                                    //   Dio dio = Dio();

                                    //   try {
                                    //     var dir = await getApplicationDocumentsDirectory();
                                    //     print("path ${dir.path}");
                                    //     await dio.download(imgUrl, "${dir.path}/samastha-.mp4",
                                    //         onReceiveProgress: (rec, total) {
                                    //       print("Rec: $rec , Total: $total");

                                    //       setState(() {
                                    //         downloading = true;
                                    //         progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
                                    //       });
                                    //     });
                                    //   } catch (e) {
                                    //     print(e);
                                    //   }

                                    //   setState(() {
                                    //     downloading = false;
                                    //     progressString = "Completed";
                                    //   });
                                    //   print("Download completed");
                                    // }
                                    // bloc.saveSubject(e.id!).then((value) {
                                    //   setState(() {
                                    //     lessonFuture = bloc.fetchLessons(
                                    //         widget.subjectId,
                                    //         widget.batchId,
                                    //         pageView.type());
                                    //   });
                                    // });
                                  }),
                        );
                      }),
                    )
                    .toList(),
              );
      case LessonItem.audioClass:
        // log('${lessons[0].mediaUrl}');
        return lessons.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _Item(
                  icon: Assets.svgs.courseAudio.svg(),
                  name: 'Currently there are no audio\n classes to show',
                  textStyle: titleLarge.darkBG.copyWith(fontSize: 15),
                  onClick: null,
                ),
              ))
            : Column(
                children: lessons
                    .map((e) => AudioClassItem(
                        name: e.title ?? '',
                        id: e.id!,
                        description: e.description,
                        isDemo: true,
                        isPurchased: true,
                        duration: e.videoDuration,
                        url: e.mediaUrl ?? ''))
                    .toList(),
              );
      case LessonItem.textBook:
        return lessons.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _Item(
                  icon: Assets.svgs.pdfTextBook.svg(height: 35),
                  name: 'Currently there are no text\n books to show',
                  textStyle: titleLarge.darkBG.copyWith(fontSize: 15),
                  onClick: null,
                ),
              ))
            : Column(
                children: lessons
                    .map((e) => NotesClassItem(
                          name: e.title!,
                          id: 1,
                          url: e.url,
                          title: e.description,
                        ))
                    .toList(),
              );

      case LessonItem.notes:
        return lessons.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _Item(
                  icon: Assets.svgs.coueseNote.svg(),
                  name: 'Currently there are\n no notes to show',
                  textStyle: titleLarge.darkBG.copyWith(fontSize: 15),
                  onClick: null,
                ),
              ))
            : Column(
                children: lessons
                    .map((e) => NotesClassItem(
                          name: e.title!,
                          id: 1,
                          url: e.url,
                          title: e.description,
                        ))
                    .toList(),
              );
      case LessonItem.liveClass:
        return Container();
    }
  }
}

class _VideoClassItem extends StatelessWidget {
  const _VideoClassItem(
      {required this.name,
      required this.id,
      this.url,
      this.duration,
      this.description,
      required this.isDownloaded,
      this.onDownloadPressed,
      required this.thumbnailUrl});

  final String name;
  final int id;
  final String? url, duration, description;
  final bool isDownloaded;
  final String thumbnailUrl;
  final void Function()? onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    log('thumb ${thumbnailUrl}');
    return Container(
      padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 10),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 1, color: const Color(0xffEBEBEB))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 74,
              height: 74,
              constraints: const BoxConstraints(minHeight: 74),
              decoration: BoxDecoration(
                image: url == null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(thumbnailUrl),
                        fit: BoxFit.fitHeight),
              ),
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
                  style: bodyMedium.darkBG,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(8),
                Row(
                  children: [
                    Text(
                      duration ?? "",
                      style: labelMedium.secondary,
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: onDownloadPressed,
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
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.onClick,
    required this.name,
    this.textStyle,
  });
  final Widget icon;
  final Function()? onClick;
  final String name;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 16,
                spreadRadius: 0,
                color: ColorResources.primary.withOpacity(.3),
                offset: const Offset(0, 8),
              )
            ], shape: BoxShape.circle, color: ColorResources.primary),
            padding: const EdgeInsets.all(16),
            child: icon,
          ),
          const Gap(13),
          Text(
            name,
            textAlign: TextAlign.center,
            style: textStyle ?? bodyMedium.grey1,
          ),
        ],
      ),
    );
  }
}
