import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/isparent_loged_in_details.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/controller/course_controller.dart';
import 'package:samastha/modules/courses/models/course_chapters_model.dart';
import 'package:samastha/modules/courses/models/course_model.dart';
import 'package:samastha/modules/courses/screens/audio_class_item.dart';
import 'package:samastha/modules/courses/screens/chapter_details_screen.dart';
import 'package:samastha/modules/courses/screens/demo_lessons_item.dart';
import 'package:samastha/modules/courses/screens/live_class_item.dart';
import 'package:samastha/modules/courses/screens/notes_class_item.dart';
import 'package:samastha/modules/courses/screens/video_class_item.dart';
import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
import 'package:samastha/modules/madrasa/controller/video_download_controller.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/utils/snackbar_utils.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/custom_tab_bar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen(
      {super.key,
      required this.courseId,
      required this.courseName,
      this.isPurchased = false});

  final int courseId;
  final String courseName;
  final bool isPurchased;

  static const String path = '/course-detail';

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool isExpanded = false;

  // List<Widget> item = [];

  final audioPlayerController = AudioPlayer();

  late PageController pageController;

  LessonItem selectedTab = LessonItem.videoClass;

  late Future<CourseModel> courseDetailFuture;
  late Future<CourseChaptersData> courseChaptersFuture;

  CourseController bloc = CourseController();

  @override
  void initState() {
    courseDetailFuture = bloc.courseDetail(widget.courseId);
    courseChaptersFuture = bloc.fetchCourseChapters(
        widget.courseId, typeFromPageMode(selectedTab));
    pageController = PageController(initialPage: selectedTab.index);
    // setState(() {
    //   item.addAll([
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //     WhatToDoItem(
    //       title: AppConstants.lorem,
    //     ),
    //   ]);
    // });
    tabController =
        TabController(length: widget.isPurchased ? 5 : 4, vsync: this);

    super.initState();
  }

  late TabController tabController;

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

  audioInit() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    audioPlayerController.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      log('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await audioPlayerController.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    audioPlayerController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      audioPlayerController.stop();
    }
  }

  _PageMode _pageMode = _PageMode.allTopics;

  Widget _buildModeSwitcher() {
    const white = Color(0xffEBEBEB);
    const grey = Color(0xfff0f0f0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _pageMode = _PageMode.allTopics;
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.allTopics ? white : grey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(0), // Adjusted
                  bottomRight: Radius.circular(0), // Adjusted
                ),
              ),
              child: Center(
                child: Text(
                  'All Topics',
                  textAlign: TextAlign.center,
                  style: _pageMode == _PageMode.allTopics
                      ? titleSmall.darkBG
                      : titleSmall.copyWith(
                          color: ColorResources.darkBG.withOpacity(.5),
                        ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                courseChaptersFuture = bloc.fetchCourseChapters(
                    widget.courseId, typeFromPageMode(selectedTab),
                    isCompleted: true);
                _pageMode = _PageMode.completedTopics;
              });
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _pageMode == _PageMode.completedTopics ? white : grey,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(0), // Adjusted
                  bottomLeft: Radius.circular(0), // Adjusted
                ),
              ),
              child: Center(
                child: Text(
                  'Completed Topics',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _pageMode == _PageMode.completedTopics
                      ? titleSmall.darkBG
                      : titleSmall.copyWith(
                          color: ColorResources.darkBG.withOpacity(.5)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    titleWidget(String title) => Text(
          title,
          style: titleLarge.darkBG,
        );
    aboutWidget(String desc) => Text(
          desc,
          style: bodyMedium.grey1,
        );
    return Scaffold(
      body: FutureBuilder<CourseModel>(
        future: courseDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return errorReload(snapshot.error.toString(), onTap: () {
              setState(() {
                courseDetailFuture = bloc.courseDetail(widget.courseId);
              });
            });
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const LoadingWidget();
            case ConnectionState.done:
              CourseModel data = snapshot.data!;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 220,
                    title: Text(
                      widget.courseName,
                      style: titleLarge.white,
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Share.share(data.courseLink ?? "");
                          },
                          icon: Assets.svgs.shareIcon.svg())
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                          // ImageViewer(path: data.photoUrl),
                          SignedImageLoader(
                        path: data.photoUrl,
                        imageBuilder: (image, loading) {
                          log('data.image ${data.image}');
                          log('data.photoUrl ${data.photoUrl}');
                          return Container(
                            width: double.maxFinite,
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(-0.00, -1.00),
                                end: const Alignment(0, 1),
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0)
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              image: data.photoUrl == null
                                  ? null
                                  : DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          data.photoUrl ?? ''),
                                      fit: BoxFit.cover),
                            ),
                          );
                        },
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(18),
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    elevation: 0,
                    scrolledUnderElevation: 0,
                  ),
                  SliverToBoxAdapter(
                    child: widget.isPurchased
                        ? afterPurchaseWidget(titleWidget(data.title ?? ""),
                            aboutWidget(data.description ?? ""), context, data)
                        : beforePurchaseWidget(titleWidget(data.title ?? ""),
                            aboutWidget(data.description ?? ""), context, data),
                  )
                ],
              );

            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget demoLessonBuilder(List<Lesson> demoList) {
    switch (selectedTab) {
      case LessonItem.videoClass:
        return demoList.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(bottom: 18.0, left: 12.0),
                child: Text('No demo lessons'),
              )
            : Column(
                children: [
                  ...demoList.map((e) => GestureDetector(
                      onTap: () {
                        log('cuurces list ${demoList.first.url}');
                        Navigator.pushNamed(context, ChapterDetailsScreen.path,
                            arguments: {
                              'data': demoList,
                              'currentIndex': demoList.indexOf(e)
                            });
                        // Navigator.pushNamed(context, ChapterDetailsScreen.path,
                        //     arguments: {
                        //       'data': demoList,
                        //       'currentIndex': demoList.indexOf(e)
                        //     });
                      },
                      child: DemoLessonsItem(
                        lesson: e,
                      )))
                ],
              );
      case LessonItem.audioClass:
        return demoList.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(bottom: 18.0, left: 12.0),
                child: Text('No demo lessons'),
              )
            : Column(children: [
                ...demoList.map((e) => AudioClassItem(
                      name: e.title ?? 'Demo audio ${demoList.indexOf(e) + 1}',
                      id: e.id!,
                      url: e.mediaUrl!,
                      isPurchased: true,
                      isDemo: true,
                    ))
              ]);
      case LessonItem.textBook:
        return demoList.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(bottom: 18.0, left: 12.0),
                child: Text('No demo lessons'),
              )
            : Column(children: [
                ...demoList.map((e) => NotesClassItem(
                      name: e.title ?? 'Demo chapter',
                      id: e.id!,
                      url: e.url,
                    ))
              ]);
      case LessonItem.notes:
        return demoList.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(bottom: 18.0, left: 12.0),
                child: Text('No demo lessons'),
              )
            : Column(children: [
                ...demoList.map((e) => NotesClassItem(
                      name: e.title ?? 'Demo chapter',
                      id: e.id!,
                      url: e.url,
                    ))
              ]);
      default:
        return Container();
    }
  }

  Widget tabBodyBuilder(CourseChaptersData data, bool isPurchased) {
    final courceData =
        data.subjectLessons?.where((element) => element.isDemo == 0).toList();

    log('cource data is model ${courceData}');
    var bodyPadding = const EdgeInsets.only(bottom: 90, left: 24, right: 24);
    switch (selectedTab) {
      case LessonItem.videoClass:
        return courceData == null && courceData?.length == 0
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
            : ListView.builder(
                itemCount: courceData?.length,
                itemBuilder: (context, index) {
                  log('courses purchased is ${widget.isPurchased}');
                  return Consumer<VideoDownloadController>(
                      builder: (context, controller, _) {
                    final e = courceData![index];
                    return (e.isDownloadStarted ?? false)
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                        : GestureDetector(
                            onTap: isPurchased
                                ? () => Navigator.pushNamed(
                                        context, ChapterDetailsScreen.path,
                                        arguments: {
                                          'data': courceData ?? List.empty(),
                                          'currentIndex': index
                                        })
                                : null,
                            child: VideoClassItem(
                                //  name: courceData[index].downloadedStatus ?? '',
                                name: courceData[index].title ??
                                    'Chapter ${index + 1}',
                                id: courceData[index].id ?? 0,
                                description: courceData[index].materialDetails,
                                duration: courceData[index].courseDuration,
                                isPurchased: widget.isPurchased,
                                imageUrl: courceData[index].image,
                                isDownloaded:
                                    courceData[index].downloadedStatus ==
                                            'downloaded'
                                        ? true
                                        : false,
                                onDownloadPressed: () async {
                                  if (e.downloadedStatus != 'downloaded') {
                                    MadrasaController blocOne =
                                        MadrasaController();
                                    await controller
                                        .downloadFileCources(e.url ?? '', e)
                                        .whenComplete(() {
                                      try {
                                        blocOne
                                            .saveSubject(e.id!)
                                            .then((value) {
                                          log('subeject saved to $value');
                                          if (IsParentLogedInDetails
                                              .isParentLogedIn()) {
                                            // setState(() {
                                            //   courseChaptersFuture =
                                            //       bloc.fetchCourseChapters(
                                            //           widget.courseId,
                                            //           typeFromPageMode(selectedTab),
                                            //           isCompleted: _pageMode ==
                                            //               _PageMode.completedTopics);
                                            //   // lessonFuture =
                                            //   //     blocOne.fetchLessonsParrent(
                                            //   //         widget.subjectId,
                                            //   //         widget.batchId,
                                            //   //         pageView.type());
                                            // });

                                            return;
                                          }

                                          setState(() {
                                            courseChaptersFuture =
                                                bloc.fetchCourseChapters(
                                                    widget.courseId,
                                                    typeFromPageMode(
                                                        selectedTab),
                                                    isCompleted: _pageMode ==
                                                        _PageMode
                                                            .completedTopics);
                                            // lessonFuture =
                                            //     blocOne.fetchLessonsParrent(
                                            //         widget.subjectId,
                                            //         widget.batchId,
                                            //         pageView.type());
                                          });
                                          // setState(() {
                                          //   lessonFuture = bloc.fetchLessons(
                                          //       widget.subjectId,
                                          //       widget.batchId,
                                          //       pageView.type());
                                          // });
                                        });
                                      } catch (e) {
                                        log('error subeject is $e');
                                        setState(() {
                                          courseChaptersFuture =
                                              bloc.fetchCourseChapters(
                                                  widget.courseId,
                                                  typeFromPageMode(selectedTab),
                                                  isCompleted: _pageMode ==
                                                      _PageMode.allTopics);
                                          // lessonFuture =
                                          //     blocOne.fetchLessonsParrent(
                                          //         widget.subjectId,
                                          //         widget.batchId,
                                          //         pageView.type());
                                        });
                                      }
                                    });

                                    SnackBarCustom.success(
                                        'video downloaded successfully');
                                  } else {
                                    // final data = await VideoDownlaodLocalClass
                                    //     .getAllLocalVidoeFiles();

                                    // log('data is ${data?.first.title}');
                                    SnackBarCustom.success(
                                        'The video is already downloaded');
                                  }
                                }
                                //     bloc.saveCourse(courceData[index].id!).then((value) {
                                //   setState(() {
                                //     courseChaptersFuture = bloc.fetchCourseChapters(
                                //         widget.courseId,
                                //         typeFromPageMode(selectedTab)); //todo
                                //   });
                                // }),
                                ),
                          );
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                padding: bodyPadding,
                shrinkWrap: true,
              );

      case LessonItem.audioClass:
        return data.subjectLessons!.isEmpty
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
            : ListView.builder(
                itemCount: data.subjectLessons?.length,
                padding: pagePadding,
                shrinkWrap: true,
                itemBuilder: (context, index) => AudioClassItem(
                    name: 'Chapter ${index + 1}',
                    id: data.subjectLessons?[index].id ?? 0,
                    isPurchased: widget.isPurchased,
                    duration: data.subjectLessons?[index].courseDuration,
                    description: data.subjectLessons?[index].description,
                    url: data.subjectLessons?[index].mediaUrl ?? ''));

      case LessonItem.textBook:
        return data.subjectLessons!.isEmpty
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
            : ListView.builder(
                itemCount: data.subjectLessons?.length,
                padding: pagePadding,
                shrinkWrap: true,
                itemBuilder: (context, index) => NotesClassItem(
                      name: 'Chapter ${index + 1}',
                      id: 1,
                      isPurchased: widget.isPurchased,
                      url: data.subjectLessons?[index].mediaUrl,
                      title: data.subjectLessons?[index].title,
                    ));

      // return ListView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   padding: bodyPadding,
      //   shrinkWrap: true,
      //   children: const [
      //     NotesClassItem(name: 'Chapter 1', id: 1),
      //     NotesClassItem(name: 'Chapter 2', id: 1),
      //     NotesClassItem(name: 'Chapter 3', id: 1),
      //   ],
      // );
      case LessonItem.notes:
        return data.subjectLessons!.isEmpty
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
            : ListView.builder(
                itemCount: data.subjectLessons?.length,
                padding: pagePadding,
                shrinkWrap: true,
                itemBuilder: (context, index) => NotesClassItem(
                      name: 'Chapter ${index + 1}',
                      id: 1,
                      isPurchased: widget.isPurchased,
                      url: data.subjectLessons?[index].url,
                      title: data.subjectLessons?[index].title,
                    ));

      // return ListView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   padding: bodyPadding,
      //   shrinkWrap: true,
      //   children: const [
      //     NotesClassItem(name: 'Chapter 1', id: 1),
      //     NotesClassItem(name: 'Chapter 2', id: 1),
      //     NotesClassItem(name: 'Chapter 3', id: 1),
      //   ],
      // );
      case LessonItem.liveClass:
        return data.subjectLessons!.isEmpty
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _Item(
                  icon: Assets.svgs.courseLive.svg(),
                  name: 'Currently there are no live\n classes to show',
                  textStyle: titleLarge.darkBG.copyWith(fontSize: 15),
                  onClick: null,
                ),
              ))
            : ListView.builder(
                itemCount: data.subjectLessons?.length,
                padding: pagePadding,
                shrinkWrap: true,
                itemBuilder: (context, index) => LiveClassItem(
                      name: 'Chapter ${index + 1}',
                      id: 1,
                      url: data.subjectLessons?[index].url,
                      title: data.subjectLessons?[index].title,
                    ));

      // return ListView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   padding: bodyPadding,
      //   shrinkWrap: true,
      //   children: const [
      //     LiveClassItem(name: 'Chapter 1', id: 1),
      //     LiveClassItem(name: 'Chapter 1', id: 1),
      //     LiveClassItem(name: 'Chapter 1', id: 1),
      //   ],
      // );

      default:
        return Container();
    }
  }

  SingleChildScrollView beforePurchaseWidget(Text titleWidget, Text aboutWidget,
      BuildContext context, CourseModel data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: courseChaptersFuture,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Padding(
                          padding: pagePadding.copyWith(top: 0, bottom: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titleWidget,
                              const Gap(14),
                              aboutWidget,
                              const Gap(16),
                              Row(
                                children: [
                                  Text(
                                    '${AppConstants.rupeeSign}${data.price}',
                                    style: headlineMedium.primary,
                                  ),
                                  const Spacer(),
                                  Assets.svgs.clock.svg(),
                                  const Gap(4),
                                  Text(
                                    data.courseDuration ?? "",
                                    style: titleSmall.secondary,
                                  ),
                                ],
                              ),
                              const Gap(24),
                              Text(
                                'What we will cover?',
                                style: titleMedium.darkBG,
                              ),
                              const Gap(16),
                              Html(data: data.whatWillLearn ?? ""),
                              // if (!isExpanded)
                              //   Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       ...item.sublist(0, 4).map((e) => e).toList(),
                              //       GestureDetector(
                              //         onTap: () {
                              //           setState(() {
                              //             isExpanded = true;
                              //           });
                              //         },
                              //         child: Text(
                              //           '+9 more',
                              //           style: titleMedium.secondary,
                              //         ),
                              //       )
                              //     ],
                              //   )
                              // else
                              //   ...item.map((e) => e).toList(),
                              const Gap(32),
                              Text(
                                'Study Materials',
                                style: titleMedium.darkBG,
                              ),
                              const Gap(24),
                              Row(
                                children: [
                                  Expanded(
                                      child: _Item(
                                    icon: Assets.svgs.courseVideo.svg(),
                                    name: 'Video',
                                    onClick: () {},
                                  )),
                                  Expanded(
                                      child: _Item(
                                    icon: Assets.svgs.courseAudio.svg(),
                                    name: 'Audio',
                                    onClick: () {},
                                  )),
                                  Expanded(
                                      child: _Item(
                                    icon: Assets.svgs.coueseNote.svg(),
                                    name: 'Notes',
                                    onClick: () {},
                                  )),
                                  Expanded(
                                      child: _Item(
                                    icon: Assets.svgs.courseLive.svg(),
                                    name: 'Live Class',
                                    onClick: () {},
                                  )),
                                ],
                              ),
                              const Gap(42),
                              Text(
                                'Demo Lessons',
                                style: titleMedium.darkBG,
                              ),
                              const Gap(18),
                              Builder(
                                builder: (context) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    var demoList =
                                        snapshot.data?.demoLessons ?? [];
                                    return demoLessonBuilder(demoList);
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              Text(
                                'Lessons',
                                style: titleMedium.darkBG,
                              ),
                              const Gap(6),
                              CustomTabBar(
                                onTap: (index) {
                                  setState(() {
                                    selectedTab = LessonItem.values[index];
                                    courseChaptersFuture =
                                        bloc.fetchCourseChapters(
                                            widget.courseId,
                                            LessonItem.values[index].type());
                                  });
                                },
                                controller: tabController,
                                tabs: const [
                                  'Video Classes',
                                  'Audio Classes',
                                  'Text Book',
                                  'Notes'
                                ],
                                indicatorColor: Colors.transparent,
                                labelStyle: titleSmall.darkBG,
                                labelColor: ColorResources.darkBG,
                                unselectedLabelColor: ColorResources.darkBG,
                                unselectedLabelStyle: labelMedium,
                                bgColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const Gap(8),
                        Builder(
                          builder: (_) {
                            if (snapshot.hasError) {
                              return errorReload(snapshot.error.toString(),
                                  onTap: () => courseChaptersFuture =
                                      bloc.fetchCourseChapters(widget.courseId,
                                          typeFromPageMode(selectedTab),
                                          isCompleted: _pageMode ==
                                              _PageMode.completedTopics));
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                return tabBodyBuilder(
                                    snapshot.data!, widget.isPurchased);
                              case ConnectionState.waiting:
                                return const Center(child: LoadingWidget());
                              default:
                                return Container();
                            }
                          },
                        ),
                      ],
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SubmitButton(
                  'Enroll now',
                  onTap: (loader) {
                    debugPrint(data.courseLink);
                    if (data.courseLink == null) {
                      showErrorMessage('No link available!');
                      return;
                    }
                    launchUrl(Uri.parse(data.courseLink!));
                    // Navigator.pushNamed(context, CartScreen.path);
                  },
                ),
              ),
              const Gap(130)
            ],
          ),
        ],
      ),
    );
  }

  afterPurchaseWidget(Text titleWidget, Text aboutWidget, BuildContext context,
      CourseModel data) {
    return SingleChildScrollView(
      child: Column(children: [
        PaddedColumn(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const Gap(16),
            titleWidget,
            const Gap(14),
            aboutWidget,
            const Gap(16),
            _buildModeSwitcher(),
          ],
        ),
        const Gap(27),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LessonButton(
                  selectedTab: selectedTab,
                  value: LessonItem.videoClass,
                  onTap: () {
                    setState(() {
                      selectedTab = LessonItem.videoClass;
                      courseChaptersFuture = bloc.fetchCourseChapters(
                          widget.courseId,
                          typeFromPageMode(LessonItem.videoClass));
                    });
                  },
                  name: "Video Class"),
              LessonButton(
                  selectedTab: selectedTab,
                  value: LessonItem.audioClass,
                  onTap: () {
                    setState(() {
                      selectedTab = LessonItem.audioClass;
                      courseChaptersFuture = bloc.fetchCourseChapters(
                          widget.courseId,
                          typeFromPageMode(LessonItem.audioClass));
                    });
                  },
                  name: "Audio Class"),
              LessonButton(
                  selectedTab: selectedTab,
                  value: LessonItem.textBook,
                  onTap: () {
                    setState(() {
                      selectedTab = LessonItem.textBook;
                      courseChaptersFuture = bloc.fetchCourseChapters(
                          widget.courseId,
                          typeFromPageMode(LessonItem.textBook));
                    });
                  },
                  name: "Text Book"),
              LessonButton(
                  selectedTab: selectedTab,
                  value: LessonItem.notes,
                  onTap: () {
                    setState(() {
                      selectedTab = LessonItem.notes;
                      courseChaptersFuture = bloc.fetchCourseChapters(
                          widget.courseId, typeFromPageMode(LessonItem.notes));
                    });
                  },
                  name: "Notes"),
              LessonButton(
                  selectedTab: selectedTab,
                  value: LessonItem.liveClass,
                  onTap: () {
                    setState(() {
                      selectedTab = LessonItem.liveClass;
                      courseChaptersFuture = bloc.fetchCourseChapters(
                          widget.courseId,
                          typeFromPageMode(LessonItem.liveClass));
                    });
                  },
                  name: "Live Class"),
            ],
          ),
        ),
        const Gap(16),
        FutureBuilder(
            future: courseChaptersFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return errorReload(snapshot.error.toString(),
                    onTap: () => courseChaptersFuture =
                        bloc.fetchCourseChapters(
                            widget.courseId, typeFromPageMode(selectedTab)));
              }
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return tabBodyBuilder(snapshot.data!, widget.isPurchased);
                case ConnectionState.waiting:
                  return const Center(child: LoadingWidget());
                default:
                  return Container();
              }
            }),
      ]),
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

enum _PageMode { allTopics, completedTopics }

enum LessonItem { videoClass, audioClass, textBook, notes, liveClass }

extension lessionName on LessonItem {
  String name() {
    switch (this) {
      case LessonItem.videoClass:
        return 'Video Classes';
      case LessonItem.audioClass:
        return 'Audio Class';

      case LessonItem.textBook:
        return 'Text Book';
      case LessonItem.notes:
        return 'Notes';
      case LessonItem.liveClass:
        return 'Live Class';
    }
  }

  String type() {
    switch (this) {
      case LessonItem.videoClass:
        return 'video';
      case LessonItem.audioClass:
        return 'audio';
      case LessonItem.textBook:
        return 'text-book';
      case LessonItem.notes:
        return 'notes';
      case LessonItem.liveClass:
        return 'live';
    }
  }
}

class LessonButton extends StatelessWidget {
  const LessonButton(
      {super.key,
      required this.onTap,
      required this.name,
      required this.selectedTab,
      required this.value});
  final Function() onTap;
  final String name;
  final LessonItem selectedTab;
  final LessonItem value;
  // final

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: selectedTab == value ? Colors.white : const Color(0xfff0f0f0),
        padding: const EdgeInsets.all(11.0),
        child: Text(
          name,
          style: selectedTab == value ? titleSmall.darkBG : labelMedium.darkBG,
        ),
      ),
    );
  }
}
