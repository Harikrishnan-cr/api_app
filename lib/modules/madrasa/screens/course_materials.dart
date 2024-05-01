import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/courses/screens/audio_class_item.dart';
import 'package:samastha/modules/courses/screens/course_detail_screen.dart';
import 'package:samastha/modules/courses/screens/notes_class_item.dart';
import 'package:samastha/modules/courses/screens/video_class_item.dart';
import 'package:samastha/modules/courses/screens/video_player_screen.dart';
import 'package:samastha/modules/madrasa/controller/time_table_controller.dart';
import 'package:samastha/modules/madrasa/models/batch_lesson_model.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class CourseMaterialsScreen extends StatefulWidget {
  const CourseMaterialsScreen({super.key, required this.batchLessonId});
  static const String path = '/course-materials';
  final int batchLessonId;

  @override
  State<CourseMaterialsScreen> createState() => _CourseMaterialsScreenState();
}

class _CourseMaterialsScreenState extends State<CourseMaterialsScreen> {
  LessonItem pageView = LessonItem.values[0];
  TimeTableController bloc = TimeTableController();
  late Future batchLessonFuture;

  onPageViewChange(LessonItem newItem) {
    setState(() {
      pageView = newItem;
      batchLessonFuture = bloc.fetchBatchLessons(
          batchLessonId: widget.batchLessonId,
          type: typeFromPageMode(pageView));
    });
  }

  String typeFromPageMode(LessonItem lessonItem) {
    switch (lessonItem) {
      case LessonItem.videoClass:
        return 'video';
      case LessonItem.audioClass:
        return 'audio';
      case LessonItem.textBook:
        return 'textbook';
      case LessonItem.notes:
        return 'notes';
      case LessonItem.liveClass:
        return 'live';
    }
  }

  @override
  void initState() {
    batchLessonFuture = bloc.fetchBatchLessons(
        batchLessonId: widget.batchLessonId, type: typeFromPageMode(pageView));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Materials'),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Container(
          width: double.infinity,
          decoration: defaultDecoration,
          // padding: EdgeInsets.all(10),
          child: Column(
            children: [
              //header
              Container(
                color: const Color(0xffECECEC),
                child: Row(
                  children: [
                    for (var i = 0; i < LessonItem.values.length - 1; i++)
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              onPageViewChange(LessonItem.values[i]);
                            },
                            child: Container(
                              height: 40,
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8)),
                                  color: pageView == LessonItem.values[i]
                                      ? Colors.white
                                      : const Color(0xffECECEC)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    LessonItem.values[i].name(),
                                    style: pageView == LessonItem.values[i]
                                        ? titleSmall.darkBG
                                        : labelMedium.darkBG,
                                  ),
                                ),
                              ),
                            )),
                      )
                  ],
                ),
              ),
              const Gap(16),
              FutureBuilder(
                  future: batchLessonFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return errorReload(snapshot.error.toString(), onTap: () {
                        setState(() {
                          batchLessonFuture = bloc.fetchBatchLessons(
                              batchLessonId: widget.batchLessonId,
                              type: typeFromPageMode(pageView));
                        });
                      });
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const LoadingWidget();
                      case ConnectionState.done:
                        // CourseModel data = snapshot.data!;
                        List<BatchLessonModel> data = snapshot.data ?? [];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: pageBodyBuilder(data),
                        );
                      default:
                        return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageBodyBuilder(List<BatchLessonModel> data) {
    switch (pageView) {
      case LessonItem.videoClass:
        List<LessonMediaModel> mediaModel = List.generate(
            data.length,
            (index) => LessonMediaModel(
                  description: data[index].description,
                  downloadedStatus: data[index].downloadedStatus,
                  id: data[index].id,
                  isFree: data[index].isFree,
                  materialDetails: data[index].materialDetails,
                  media: [],
                  mediaUrl: data[index].mediaUrl,
                  popupQuestion: data[index].popupQuestion,
                  subtitle: data[index].subTitle,
                  title: data[index].title,
                  type: data[index].type,
                  url: data[index].url,
                  videoDuration: data[index].videoDuration,
                ));
        return data.isEmpty
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
            : Column(children: [
                ...data.map((e) => GestureDetector(
                      onTap: () {
                        print('video play data ${data.indexOf(e)}');
                        print('video play data ind ${data.indexOf(e)}');
                        Navigator.pushNamed(context, VideoPlayerScreen.path,
                            arguments: {
                              "lessons": mediaModel,
                              "currentIndex": data.indexOf(e)
                            });
                      },
                      child: VideoClassItem(
                        isDownloaded: false,
                        isPurchased: true,
                        id: e.id!,
                        name: e.title ?? '',
                        description: e.description,
                        duration: e.videoDuration,
                        onDownloadPressed: null,
                        imageUrl: e.mediaUrl,
                      ),
                    ))
              ]);

      // Column(
      //   // shrinkWrap: true,
      //   children: [
      //     _VideoClassItem(name: AppConstants.lorem, id: 1),
      //     const _VideoClassItem(name: 'name', id: 1),
      //     const _VideoClassItem(name: 'name', id: 1),
      //   ],
      // );

      case LessonItem.audioClass:
        return data.isEmpty
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
            : Column(children: [
                ...data.map((e) => AudioClassItem(
                      id: e.id!,
                      name: e.title ?? '',
                      url: e.mediaUrl ?? '',
                      isPurchased: true,
                    ))
              ]);
      // const Column(
      //   children: [
      //     AudioClassItem(
      //         name: 'Fiqh',
      //         id: 1,
      //         url:
      //             'https://actions.google.com/sounds/v1/foley/deep_cross_on_wood.ogg'),
      //   ],
      // );
      case LessonItem.textBook:
        return data.isEmpty
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
            : Column(children: [
                ...data.map((e) => NotesClassItem(
                      id: e.id!,
                      name: e.title ?? '',
                    ))
              ]);
      // const Column(
      //   children: [
      //     NotesClassItem(name: 'book 1 dc-12', id: 1),
      //   ],
      // );
      case LessonItem.notes:
        return data.isEmpty
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
            : Column(children: [
                ...data.map((e) => NotesClassItem(
                      id: e.id!,
                      name: e.title ?? '',
                    ))
              ]);
      // const Column(
      //   children: [
      //     NotesClassItem(name: 'note 1', id: 1),
      //     NotesClassItem(name: 'note 2', id: 1),
      //   ],
      // );
      case LessonItem.liveClass:
        return Container();
    }
  }
}

class _VideoClassItem extends StatelessWidget {
  const _VideoClassItem({
    required this.name,
    required this.id,
  });

  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
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
                // Text(
                //   name,
                //   style: titleSmall.grey1,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
                // const Gap(8),
                Text(
                  'How To Pray Salah - step by step lessons',
                  style: bodyMedium.darkBG,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(8),
                Row(
                  children: [
                    Text(
                      '02:10',
                      style: labelMedium.secondary,
                    ),
                    const Spacer(),
                    Assets.svgs.circleDownload.svg(),
                    const Gap(15),
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
