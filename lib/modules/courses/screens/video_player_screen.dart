// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/modules/courses/controller/video_speed_provider.dart';
import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/courses/screens/next_item.dart';
import 'package:samastha/modules/courses/screens/prev_item.dart';
import 'package:samastha/modules/courses/screens/thumbnail_item.dart';
import 'package:samastha/modules/dashboard/controller/dashboard_controller.dart';
import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:video_player/video_player.dart';
import 'package:samastha/modules/courses/models/course_chapters_model.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({
    super.key,
    required this.currentIndex,
    required this.lessonList,
  });
  int currentIndex;
  final List<LessonMediaModel> lessonList;

  static const String path = '/video-play';

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  String time = '1h 30m';

  // LessonMediaModel get selectedLesson => widget.lessonList[widget.currentIndex];
  late LessonMediaModel selectedLesson;

  void onPrint() {
    for (int i = 0; i < widget.lessonList.length; i++) {
      log('lessonn list ${widget.lessonList[i].title}');
    }
  }

  @override
  void initState() {
    selectedLesson = widget.lessonList[widget.currentIndex];
    print('\nvideo player\n');
    // TODO : sourav remove this line
    // widget.lessonList.add(widget.lessonList.first);
    // widget.lessonList.add(widget.lessonList.first);
    // widget.lessonList.add(widget.lessonList.first);
    // widget.lessonList.add(widget.lessonList.first);
    // TODO : sourav close

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onPrint();
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Video Class'),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedLesson.title ?? "",
              style: titleLarge.copyWith(
                color: const Color(0xff1B3D66),
              ),
            ),
            const Gap(8),
            Text(
              selectedLesson.description ?? "",
              style: bodyMedium.grey1,
            ),
            const Gap(19),
            //TODO: sourav use  singedimageviwer() => return isLoaded ? customPlayer: loader
            _CustomPlayer(model: widget.lessonList[widget.currentIndex]),
            if (widget.lessonList.length > 1) ...[
              const Gap(16),
              Row(
                children: [
                  PrevItem(
                    thumb: widget.currentIndex == 0
                        ? null
                        : widget
                            .lessonList[widget.currentIndex - 1].thumbnailUrl,
                    callBack: widget.currentIndex == 0
                        ? null
                        : () {
                            log('widget currnt index ${widget.lessonList[widget.currentIndex].url}');
                            setState(() {
                              widget.currentIndex -= 1;
                              selectedLesson =
                                  widget.lessonList[widget.currentIndex];
                            });
                          },
                  ),
                  const Gap(10),
                  NextItem(
                    thumb: widget.currentIndex == widget.lessonList.length - 1
                        ? null
                        : widget
                            .lessonList[widget.currentIndex + 1].thumbnailUrl,
                    callBack:
                        widget.currentIndex == widget.lessonList.length - 1
                            ? null
                            : () {
                                log('widget currnt index ${widget.lessonList[widget.currentIndex].thumbnailUrl}');
                                setState(() {
                                  widget.currentIndex += 1;
                                  selectedLesson =
                                      widget.lessonList[widget.currentIndex];
                                });
                              },
                  )
                ],
              ),
              const Gap(35),
              // for (LessonMediaModel item in widget.lessonList)

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.lessonList.length,
                itemBuilder: (context, index) {
                  final item = widget.lessonList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.currentIndex = index;
                        selectedLesson = widget.lessonList[widget.currentIndex];
                      });
                    },
                    child: ThumbnailItem(
                      title: item.title ?? '',
                      sharkImage: item.thumbnailUrl ?? '',
                      time: item.videoDuration ?? '',
                    ),
                  );
                },
              )
            ],
          ],
        ),
      )),
    );
  }
}

class _CustomPlayer extends StatefulWidget {
  const _CustomPlayer({required this.model});
  final LessonMediaModel model;

  @override
  State<_CustomPlayer> createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<_CustomPlayer> {
  late FlickManager flickManager;
  String? tempTime;
  // String? tempUrl;
  MadrasaController bloc = MadrasaController();

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<String?> _getUrl() async {
    if (widget.model.mediaUrl == null) return null;

    // log('fetching media url is ${widget.model.url}');
    try {
      String? retrievedUrl = await getUrl(widget.model.mediaUrl!).then((value) {
        log('Error fetching URL ----------: $value');
        _initializePlayer(videoUrl: value);
        return value;
      });
      log('Error fetching URL: $retrievedUrl');
      // if(tempUrl != retrievedUrl) _initializePlayer();
      return retrievedUrl;
    } catch (e) {
      // Handle error
      log('Error fetching URL: $e');
      return null;
    }
  }

  void _initializePlayer({String? videoUrl}) async {
    // String? videoUrl = await _getUrl(); // Fetch the video URL asynchronously

    // log('video final play url not updated ${videoUrl}');
    // setState(() {
    //   tempUrl = videoUrl;
    // });
    if (videoUrl != null) {
      //setState(() {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(videoUrl),
        ),
        onVideoEnd: () {
          print('vPlayer onVideoEnd');
        },
      );

      // Set up a listener for duration changes
      flickManager.flickVideoManager?.addListener(() {
        // Handle duration changes here
        print('video listener');

        if (flickManager
            .flickVideoManager!.videoPlayerController!.value.hasError) {
          print(
              'Error occurred: ${flickManager.flickVideoManager?.videoPlayerController?.value.errorDescription}');
          // Handle the error here
        }

        Duration currentDuration = flickManager
            .flickVideoManager!.videoPlayerController!.value.position;
        if (!(flickManager
            .flickVideoManager!.videoPlayerController!.value.isPlaying)) {
          currentDuration; //set this value to paused value and save to saved-duration
          if (DateConverter.durationToTime(currentDuration) != '00:00:00') {
            bloc
                .saveDuration(widget.model.id!,
                    DateConverter.durationToTime(currentDuration))
                .then((value) {
              print('duration save $value ');
            });
          }
        }

        widget.model.popupQuestion?.forEach((element) {
          print('check:- elem dur ${element.duration}');
          print(
              'check:- convertime ${DateConverter.durationToTime(currentDuration)}');
          print(
              'check:- check equal ${element.duration == DateConverter.durationToTime(currentDuration)}');
          if (element.duration ==
              DateConverter.durationToTime(currentDuration)) {
            print('check:- 3 tempTime $tempTime');
            print(
                'check:- 3 convertime ${DateConverter.durationToTime(currentDuration)}');
            print(
                'check:- 3 check equal ${!(tempTime == DateConverter.durationToTime(currentDuration))}');
            if (!(tempTime == DateConverter.durationToTime(currentDuration))) {
              print('check:- entered popup ${tempTime}');
              tempTime = DateConverter.durationToTime(currentDuration);
              if (element.question != null) {
                flickManager.flickControlManager!.autoPause();
                openQuiz(
                    element.question!,
                    widget.model.popupQuestion!.indexOf(element),
                    currentDuration);
              }
              // ?.forEach((question) {
              //   flickManager.flickControlManager!.autoPause();
              //   openQuiz(question, element.questions!.indexOf(question),
              //       currentDuration);
              // });
            } else {
              print('check:- 2 tempTime $tempTime');
              print(
                  'check:- 2 convertime ${DateConverter.durationToTime(currentDuration)}');
              print(
                  'check:- 2 check equal ${!(tempTime == DateConverter.durationToTime(currentDuration))}');
            }
          }
        });
      });
      // });
    } else {
      // Handle case where video URL is not available
    }
  }

  openQuiz(Question question, int indexOfQuestion, Duration currentDuration) {
    //open quiz
    print('quiz opened');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // var selectedAnswerIndex = -1;
      int? selectedAnswerIndex;
      // var correctAnswer = 1;

      flickManager.flickControlManager!.autoPause();
      // Show dialog
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, state) {
          // Function to define the decoration based on the selected and correct answers
          Decoration dynamicDecoration(int? id) {
            if (selectedAnswerIndex != null &&
                question.options?[selectedAnswerIndex!].id == id) {
              return BoxDecoration(
                color: ColorResources.primary, // Color for correct answer
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: 0,
                    offset: Offset(0, 10),
                    color: Color(0xfff0f0f0),
                  )
                ],
              );
            } else {
              return BoxDecoration(
                color: Colors.white, // Default color
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: 0,
                    offset: Offset(0, 10),
                    color: Color(0xfff0f0f0),
                  )
                ],
              );
            }
          }

          // Function to handle a user's answer selection
          void handleAnswerSelection(int answerIndex) {
            state(() {
              print(selectedAnswerIndex);
              print(question.options![answerIndex].id);
              selectedAnswerIndex = answerIndex;
            });
          }

          return Dialog(
            insetPadding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(22)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Container(
                      decoration: defaultDecoration,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${indexOfQuestion + 1}. ',
                            style: titleMedium.darkBG,
                          ),
                          Expanded(
                            child: Text(
                              question.question ?? '',
                              maxLines: 4,
                              style: titleMedium.darkBG,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),

                    // Answer options
                    for (int i = 0; i < question.options!.length; i++)
                      GestureDetector(
                        onTap: () {
                          handleAnswerSelection(i);
                        },
                        child: Container(
                          decoration:
                              dynamicDecoration(question.options?[i].id),
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xffEBEBEB),
                                child: Text(
                                  String.fromCharCode('A'.codeUnitAt(0) + i),
                                  style: labelLarge.darkBG,
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                child: Text(
                                  question.options?[i].optionName ?? '',
                                  maxLines: 1,
                                  style: labelLarge.darkBG,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    CustomOutlineButton(
                      'Continue to video',
                      onTap: (loader) {
                        Navigator.pop(context);
                        flickManager.flickControlManager!.autoResume();
                        bloc
                            .submitPopupQuestion(
                                AppConstants.studentID ?? 0,
                                question.id ?? 0,
                                question.options?[selectedAnswerIndex!].id ?? 0)
                            .then((value) {
                          print('submit qstn $value');
                          // if(value){
                          SnackBarCustom.success(
                              value ? 'Correct answer' : 'Wrong answer');
                          flickManager.flickControlManager?.autoResume();
                          Navigator.pop(context);
                          // }
                        });
                      },
                      bgColor: ColorResources.secondary,
                      textColor: Colors.white,
                    ),
                    const Gap(13),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUrl(), // Use the _getUrl() method as the future
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        log('video snapshot is ${snapshot.data} get is }');
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While fetching the video URL, display a loading indicator or placeholder
          return Center(
              child:
                  CircularProgressIndicator()); // Replace with your loading widget
        } else if (snapshot.hasError) {
          // Handle errors while fetching the URL
          return Text('Error fetching video URL');
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Handle case where the video URL is not available
          return Text('Video URL not found');
        } else if (snapshot.connectionState == ConnectionState.done) {
          // If the URL is fetched successfully, initialize the video player
          if (snapshot.data != null) {
            return AspectRatio(
              aspectRatio:
                  16 / 9, //if video is in full screen change the aspect ratio
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  videoFit: BoxFit.scaleDown,
                  controls:
                      CustomFlickPortraitControls(flickManager: flickManager),
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}

// class _CustomPlayerState extends State<_CustomPlayer> {
//   late FlickManager flickManager;
//   MadrasaController bloc = MadrasaController();
//   late String? url;
//   String? tempTime;

//   Future<String?> _getUrl() async {
//     if (widget.model.mediaUrl == null) return null;
//     try {
//       url = await getUrl(widget.model.mediaUrl!);
//       print('video url $url');
//       setState(() {});
//     } catch (e) {
//       //
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     url = widget.model.url;
//     _getUrl();
//     print('initiate flick ${url}');
//     flickManager = FlickManager(
//       videoPlayerController: VideoPlayerController.networkUrl(
//         Uri.parse(url ?? ''),
//       ),
//       onVideoEnd: () {
//         print('vPlayer onVideoEnd');
//       },
//     );
//     // initiateFlick();
//     // Set up a listener for duration changes
//     flickManager.flickVideoManager?.addListener(() {
//       // Handle duration changes here
//       print('video listerner');

//       if (flickManager
//           .flickVideoManager!.videoPlayerController!.value.hasError) {
//         print(
//             'Error occurred: ${flickManager.flickVideoManager?.videoPlayerController?.value.errorDescription}');
//         // Handle the error here
//       }

//       if (flickManager
//           .flickVideoManager!.videoPlayerController!.value.hasError) {
//         print('vPlayer hasError');
//         setState(() => _getUrl());
//       }
//       Duration currentDuration =
//           flickManager.flickVideoManager!.videoPlayerController!.value.position;
//       if (!(flickManager
//           .flickVideoManager!.videoPlayerController!.value.isPlaying)) {
//         currentDuration; //set this value to paused value and save to saved-duration
//         if (DateConverter.durationToTime(currentDuration) != '00:00:00') {
//           bloc
//               .saveDuration(widget.model.id!,
//                   DateConverter.durationToTime(currentDuration))
//               .then((value) {
//             print('duration save $value ');
//           });
//         }
//       }

//       widget.model.popupQuestion?.forEach((element) {
//         print(
//             'check quiz : ${element.duration} == ${DateConverter.durationToTime(currentDuration)} : ${element.duration == DateConverter.durationToTime(currentDuration)}');
//         if (element.duration == DateConverter.durationToTime(currentDuration)) {
//           print(
//               'daetTimee !$tempTime == ${DateConverter.durationToTime(currentDuration)} : ${!(tempTime == DateConverter.durationToTime(currentDuration))} ');
//           if (!(tempTime == DateConverter.durationToTime(currentDuration))) {
//             tempTime = DateConverter.durationToTime(currentDuration);
//             print('daetTimee ${DateConverter.durationToTime(currentDuration)}');
//             element.questions?.forEach((question) {
//               print('duration : $currentDuration ; ${element.duration}');
//               flickManager.flickControlManager!.autoPause();
//               print(
//                   'add dur: $currentDuration + ${const Duration(seconds: 1)} = ${currentDuration + const Duration(seconds: 1)}');
//               // if (question.options!.isEmpty) {
//               //     flickManager.flickControlManager
//               //         ?.seekForward(const Duration(milliseconds: 800));
//               //   }
//               openQuiz(question, element.questions!.indexOf(question),
//                   currentDuration);
//             });
//           }
//         }
//       });
//       //pause player first
//       //  flickManager.flickControlManager!.playToggle();
//       // show pop up questions
//       //play again
//     });
//   }

//   openQuiz(Question question, int indexOfQuestion, Duration currentDuration) {
//     //open quiz
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // var selectedAnswerIndex = -1;
//       int? selectedAnswerIndex;
//       // var correctAnswer = 1;

//       // Show dialog
//       showDialog(
//         context: context,
//         builder: (context) => StatefulBuilder(builder: (context, state) {
//           // Function to define the decoration based on the selected and correct answers
//           Decoration dynamicDecoration(int? id) {
//             if (selectedAnswerIndex != null &&
//                 question.options?[selectedAnswerIndex!].id == id) {
//               return BoxDecoration(
//                 color: ColorResources.primary, // Color for correct answer
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 30,
//                     spreadRadius: 0,
//                     offset: Offset(0, 10),
//                     color: Color(0xfff0f0f0),
//                   )
//                 ],
//               );
//             } else {
//               return BoxDecoration(
//                 color: Colors.white, // Default color
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 30,
//                     spreadRadius: 0,
//                     offset: Offset(0, 10),
//                     color: Color(0xfff0f0f0),
//                   )
//                 ],
//               );
//             }
//           }

//           // Function to handle a user's answer selection
//           void handleAnswerSelection(int answerIndex) {
//             state(() {
//               print(selectedAnswerIndex);
//               print(question.options![answerIndex].id);
//               selectedAnswerIndex = answerIndex;
//             });
//           }

//           return Dialog(
//             insetPadding: const EdgeInsets.all(10),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(22),
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(22)),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Question
//                     Container(
//                       decoration: defaultDecoration,
//                       padding: const EdgeInsets.all(16),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${indexOfQuestion + 1}. ',
//                             style: titleMedium.darkBG,
//                           ),
//                           Expanded(
//                             child: Text(
//                               question.question ?? '',
//                               maxLines: 4,
//                               style: titleMedium.darkBG,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Gap(16),

//                     // Answer options
//                     for (int i = 0; i < question.options!.length; i++)
//                       GestureDetector(
//                         onTap: () {
//                           handleAnswerSelection(i);
//                         },
//                         child: Container(
//                           decoration:
//                               dynamicDecoration(question.options?[i].id),
//                           margin: const EdgeInsets.only(bottom: 16),
//                           padding: const EdgeInsets.all(16),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: const Color(0xffEBEBEB),
//                                 child: Text(
//                                   String.fromCharCode('A'.codeUnitAt(0) + i),
//                                   style: labelLarge.darkBG,
//                                 ),
//                               ),
//                               const Gap(16),
//                               Expanded(
//                                 child: Text(
//                                   question.options?[i].optionName ?? '',
//                                   maxLines: 1,
//                                   style: labelLarge.darkBG,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                     CustomOutlineButton(
//                       'Continue to video',
//                       onTap: (loader) {
//                         Navigator.pop(context);
//                         flickManager.flickControlManager!.autoResume();
//                         bloc
//                             .submitPopupQuestion(
//                                 AppConstants.studentID ?? 0,
//                                 question.id ?? 0,
//                                 question.options?[selectedAnswerIndex!].id ?? 0)
//                             .then((value) {
//                           print('submit qstn $value');
//                           // if(value){
//                           SnackBarCustom.success(
//                               value ? 'Correct answer' : 'Wrong answer');
//                           flickManager.flickControlManager?.autoResume();
//                           Navigator.pop(context);
//                           // }
//                         });
//                       },
//                       bgColor: ColorResources.secondary,
//                       textColor: Colors.white,
//                     ),
//                     // const Gap(16),
//                     // Center(
//                     //   child: Text(
//                     //     (selectedAnswerIndex == -1)
//                     //         ? 'Select an answer'
//                     //         : (question.options?[selectedAnswerIndex].isCorrect == 1)
//                     //             ? 'Correct answer'
//                     //             : 'Wrong answer',
//                     //     style: (selectedAnswerIndex == -1)
//                     //         ? bodyMedium.primary
//                     //         : (question.options?[selectedAnswerIndex].isCorrect == 1)
//                     //             ? bodyMedium.primary
//                     //             : bodyMedium.red,
//                     //     textAlign: TextAlign.center,
//                     //   ),
//                     // ),
//                     const Gap(13),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlickVideoPlayer(
//       flickManager: flickManager,
//       flickVideoWithControls: FlickVideoWithControls(
//         controls: CustomFlickPortraitControls(flickManager: flickManager),
//       ),
//     );
//   }
// }

/// Default portrait controls.
class CustomFlickPortraitControls extends StatelessWidget {
  const CustomFlickPortraitControls(
      {super.key,
      this.iconSize = 20,
      this.fontSize = 12,
      this.progressBarSettings,
      required this.flickManager});
  final FlickManager flickManager;

  /// Icon size.
  ///
  /// This size is used for all the player icons.
  final double iconSize;

  /// Font size.
  ///
  /// This size is used for all the text.
  final double fontSize;

  /// [FlickProgressBarSettings] settings.
  final FlickProgressBarSettings? progressBarSettings;

  @override
  Widget build(BuildContext context) {
    Provider.of<VideoSpeedProvider>(context, listen: false)
        .makeCurrentSpeedDefault(
            flickmanager: flickManager.flickControlManager);
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '5s',
                          style: labelMedium.primary,
                        ),
                        const Gap(10),
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100)),
                          child: RotatedBox(
                              quarterTurns: 2,
                              child: Assets.svgs.forward
                                  .svg(color: ColorResources.primary)),
                        ),
                        const Gap(10),
                        FlickPlayToggle(
                          // size: 40,
                          color: ColorResources.primary,
                          playChild: Assets.svgs.videoPlay
                              .svg(color: ColorResources.primary),

                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100)),
                          child: Assets.svgs.forward
                              .svg(color: ColorResources.primary),
                        ),
                        const Gap(10),
                        Text(
                          '5s',
                          style: labelMedium.primary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        FlickAutoHideChild(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlickVideoProgressBar(
                  flickProgressBarSettings: progressBarSettings,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: 2,
                      child: Assets.svgs.forward.svg(),
                    ),
                    const Gap(12),
                    FlickPlayToggle(
                      size: iconSize,
                      color: ColorResources.WHITE,
                      playChild: Assets.svgs.videoPlay.svg(),
                    ),
                    const Gap(12),
                    Assets.svgs.forward.svg(),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        FlickAutoHideChild(
                          child: Consumer<VideoSpeedProvider>(
                              builder: (context, controller, _) {
                            return CupertinoButton(
                              onPressed: () async {
                                controller.onCurrentSpeedUpdate();
                                await flickManager.flickControlManager
                                    ?.setPlaybackSpeed(controller.currentSpeed);
                              },
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              child: Container(
                                width: 35,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: ColorResources.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    '${controller.currentSpeed} x   ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Gap(10),
                        FlickCurrentPosition(
                          fontSize: fontSize,
                        ),
                        FlickAutoHideChild(
                          child: Text(
                            ' / ',
                            style: TextStyle(
                                color: Colors.white, fontSize: fontSize),
                          ),
                        ),
                        FlickTotalDuration(
                          fontSize: fontSize,
                        ),
                      ],
                    ),
                    const Gap(14),
                    FlickFullScreenToggle(
                      size: iconSize,
                      enterFullScreenChild: Assets.svgs.fullscreen.svg(),
                      exitFullScreenChild: Assets.svgs.fullscreen.svg(),
                      padding: EdgeInsets.zero,
                      toggleFullscreen: () {
                        DashboardController.i.toggleNavBarVisibility();
                        flickManager.flickControlManager?.toggleFullscreen();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// // ignore_for_file: must_be_immutable

// import 'dart:developer';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:samastha/core/app_constants.dart';
// import 'package:samastha/gen/assets.gen.dart';
// import 'package:samastha/helper/date_converter.dart';
// import 'package:samastha/modules/courses/controller/video_speed_provider.dart';
// import 'package:samastha/modules/courses/models/lesson_media_model.dart';
// import 'package:samastha/modules/courses/screens/next_item.dart';
// import 'package:samastha/modules/courses/screens/prev_item.dart';
// import 'package:samastha/modules/courses/screens/thumbnail_item.dart';
// import 'package:samastha/modules/dashboard/controller/dashboard_controller.dart';
// import 'package:samastha/modules/madrasa/controller/madrasa_controller.dart';
// import 'package:samastha/theme/color_resources.dart';
// import 'package:samastha/theme/dimensions.dart';
// import 'package:samastha/theme/t_style.dart';
// import 'package:samastha/utils/signed_image_viewer.dart';
// import 'package:samastha/widgets/app_bars_custom.dart';
// import 'package:samastha/widgets/custom_form_elements.dart';
// import 'package:samastha/widgets/custom_snackbar.dart';
// import 'package:video_player/video_player.dart';
// import 'package:samastha/modules/courses/models/course_chapters_model.dart';

// // class VideoPlayerScreen extends StatefulWidget {
// //   VideoPlayerScreen({
// //     super.key,
// //     required this.currentIndex,
// //     required this.lessonList,
// //   });
// //   int currentIndex;
// //   final List<LessonMediaModel> lessonList;

// //   static const String path = '/video-play';

// //   @override
// //   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// // }

// // class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
// //   String time = '1h 30m';

// //   // LessonMediaModel get selectedLesson => widget.lessonList[widget.currentIndex];
// //   late LessonMediaModel selectedLesson;

// //   void onPrint() {
// //     for (int i = 0; i < widget.lessonList.length; i++) {
// //       log('lessonn list ${widget.lessonList[i].title}');
// //     }
// //   }

// //   @override
// //   void initState() {
// //     selectedLesson = widget.lessonList[widget.currentIndex];
// //     print('\nvideo player\n');
// //     // TODO : sourav remove this line
// //     // widget.lessonList.add(widget.lessonList.first);
// //     // widget.lessonList.add(widget.lessonList.first);
// //     // widget.lessonList.add(widget.lessonList.first);
// //     // widget.lessonList.add(widget.lessonList.first);
// //     // TODO : sourav close

// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     onPrint();
// //     return Scaffold(
// //       appBar: const SimpleAppBar(title: 'Video Class'),
// //       body: SafeArea(
// //           child: SingleChildScrollView(
// //         padding: pagePadding,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               selectedLesson.title ?? "",
// //               style: titleLarge.copyWith(
// //                 color: const Color(0xff1B3D66),
// //               ),
// //             ),
// //             const Gap(8),
// //             Text(
// //               selectedLesson.description ?? "",
// //               style: bodyMedium.grey1,
// //             ),
// //             const Gap(19),
// //             //TODO: sourav use  singedimageviwer() => return isLoaded ? customPlayer: loader
// //             _CustomPlayer(model: widget.lessonList[widget.currentIndex]),
// //             if (widget.lessonList.length > 1) ...[
// //               const Gap(16),
// //               Row(
// //                 children: [
// //                   PrevItem(
// //                     thumb: widget.currentIndex == 0
// //                         ? null
// //                         : widget
// //                             .lessonList[widget.currentIndex - 1].thumbnailUrl,
// //                     callBack: widget.currentIndex == 0
// //                         ? null
// //                         : () {
// //                             log('widget currnt index ${widget.lessonList[widget.currentIndex].url}');
// //                             setState(() {
// //                               widget.currentIndex -= 1;
// //                               selectedLesson =
// //                                   widget.lessonList[widget.currentIndex];
// //                             });
// //                           },
// //                   ),
// //                   const Gap(10),
// //                   NextItem(
// //                     thumb: widget.currentIndex == widget.lessonList.length - 1
// //                         ? null
// //                         : widget
// //                             .lessonList[widget.currentIndex + 1].thumbnailUrl,
// //                     callBack:
// //                         widget.currentIndex == widget.lessonList.length - 1
// //                             ? null
// //                             : () {
// //                                 log('widget currnt index ${widget.lessonList[widget.currentIndex].thumbnailUrl}');
// //                                 setState(() {
// //                                   widget.currentIndex += 1;
// //                                   selectedLesson =
// //                                       widget.lessonList[widget.currentIndex];
// //                                 });
// //                               },
// //                   )
// //                 ],
// //               ),
// //               const Gap(35),
// //               // for (LessonMediaModel item in widget.lessonList)

// //               ListView.builder(
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 shrinkWrap: true,
// //                 itemCount: widget.lessonList.length,
// //                 itemBuilder: (context, index) {
// //                   final item = widget.lessonList[index];
// //                   return GestureDetector(
// //                     onTap: () {
// //                       setState(() {
// //                         widget.currentIndex = index;
// //                         selectedLesson = widget.lessonList[widget.currentIndex];
// //                       });
// //                     },
// //                     child: ThumbnailItem(
// //                       title: item.title ?? '',
// //                       sharkImage: item.thumbnailUrl,
// //                       time: item.videoDuration ?? '',
// //                     ),
// //                   );
// //                 },
// //               )
// //             ],
// //           ],
// //         ),
// //       )),
// //     );
// //   }
// // }

// // class _CustomPlayer extends StatefulWidget {
// //   const _CustomPlayer({required this.model});
// //   final LessonMediaModel model;

// //   @override
// //   State<_CustomPlayer> createState() => _CustomPlayerState();
// // }

// // class _CustomPlayerState extends State<_CustomPlayer> {
// //   late FlickManager flickManager;
// //   String? tempTime;
// //   // String? tempUrl;
// //   MadrasaController bloc = MadrasaController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializePlayer();
// //   }

// //   Future<String?> _getUrl() async {
// //     // log('media url is ${widget.model.url}');
// //     if (widget.model.mediaUrl == null) return null;

// //     log('media url is ${widget.model.url}');
// //     try {
// //       String? retrievedUrl = await getUrl(widget.model.mediaUrl!).then((value) {
// //         _initializePlayer(videoUrl: value);
// //         return value;
// //       });

// //       // if(tempUrl != retrievedUrl) _initializePlayer();
// //       return retrievedUrl;
// //     } catch (e) {
// //       // Handle error
// //       print('Error fetching URL: $e');
// //       return null;
// //     }
// //   }

// //   void _initializePlayer({String? videoUrl}) async {
// //     // String? videoUrl = await _getUrl(); // Fetch the video URL asynchronously

// //     // log('video final play url not updated ${videoUrl}');
// //     // setState(() {
// //     //   tempUrl = videoUrl;
// //     // });
// //     if (videoUrl != null) {
// //       //setState(() {
// //       flickManager = FlickManager(
// //         videoPlayerController: VideoPlayerController.networkUrl(
// //           Uri.parse(videoUrl),
// //         ),
// //         onVideoEnd: () {
// //           print('vPlayer onVideoEnd');
// //         },
// //       );

// //       // Set up a listener for duration changes
// //       flickManager.flickVideoManager?.addListener(() {
// //         // Handle duration changes here
// //         print('video listener');

// //         if (flickManager
// //             .flickVideoManager!.videoPlayerController!.value.hasError) {
// //           print(
// //               'Error occurred: ${flickManager.flickVideoManager?.videoPlayerController?.value.errorDescription}');
// //           // Handle the error here
// //         }

// //         Duration currentDuration = flickManager
// //             .flickVideoManager!.videoPlayerController!.value.position;
// //         if (!(flickManager
// //             .flickVideoManager!.videoPlayerController!.value.isPlaying)) {
// //           currentDuration; //set this value to paused value and save to saved-duration
// //           if (DateConverter.durationToTime(currentDuration) != '00:00:00') {
// //             bloc
// //                 .saveDuration(widget.model.id!,
// //                     DateConverter.durationToTime(currentDuration))
// //                 .then((value) {
// //               print('duration save $value ');
// //             });
// //           }
// //         }

// //         widget.model.popupQuestion?.forEach((element) {
// //           print('check:- elem dur ${element.duration}');
// //           print(
// //               'check:- convertime ${DateConverter.durationToTime(currentDuration)}');
// //           print(
// //               'check:- check equal ${element.duration == DateConverter.durationToTime(currentDuration)}');
// //           if (element.duration ==
// //               DateConverter.durationToTime(currentDuration)) {
// //             print('check:- 3 tempTime $tempTime');
// //             print(
// //                 'check:- 3 convertime ${DateConverter.durationToTime(currentDuration)}');
// //             print(
// //                 'check:- 3 check equal ${!(tempTime == DateConverter.durationToTime(currentDuration))}');
// //             if (!(tempTime == DateConverter.durationToTime(currentDuration))) {
// //               print('check:- entered popup ${tempTime}');
// //               tempTime = DateConverter.durationToTime(currentDuration);
// //               if (element.question != null) {
// //                 flickManager.flickControlManager!.autoPause();
// //                 openQuiz(
// //                     element.question!,
// //                     widget.model.popupQuestion!.indexOf(element),
// //                     currentDuration);
// //               }
// //               // ?.forEach((question) {
// //               //   flickManager.flickControlManager!.autoPause();
// //               //   openQuiz(question, element.questions!.indexOf(question),
// //               //       currentDuration);
// //               // });
// //             } else {
// //               print('check:- 2 tempTime $tempTime');
// //               print(
// //                   'check:- 2 convertime ${DateConverter.durationToTime(currentDuration)}');
// //               print(
// //                   'check:- 2 check equal ${!(tempTime == DateConverter.durationToTime(currentDuration))}');
// //             }
// //           }
// //         });
// //       });
// //       // });
// //     } else {
// //       // Handle case where video URL is not available
// //     }
// //   }

// //   openQuiz(Question question, int indexOfQuestion, Duration currentDuration) {
// //     //open quiz
// //     print('quiz opened');
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       // var selectedAnswerIndex = -1;
// //       int? selectedAnswerIndex;
// //       // var correctAnswer = 1;

// //       flickManager.flickControlManager!.autoPause();
// //       // Show dialog
// //       showDialog(
// //         context: context,
// //         builder: (context) => StatefulBuilder(builder: (context, state) {
// //           // Function to define the decoration based on the selected and correct answers
// //           Decoration dynamicDecoration(int? id) {
// //             if (selectedAnswerIndex != null &&
// //                 question.options?[selectedAnswerIndex!].id == id) {
// //               return BoxDecoration(
// //                 color: ColorResources.primary, // Color for correct answer
// //                 borderRadius: BorderRadius.circular(8),
// //                 boxShadow: const [
// //                   BoxShadow(
// //                     blurRadius: 30,
// //                     spreadRadius: 0,
// //                     offset: Offset(0, 10),
// //                     color: Color(0xfff0f0f0),
// //                   )
// //                 ],
// //               );
// //             } else {
// //               return BoxDecoration(
// //                 color: Colors.white, // Default color
// //                 borderRadius: BorderRadius.circular(8),
// //                 boxShadow: const [
// //                   BoxShadow(
// //                     blurRadius: 30,
// //                     spreadRadius: 0,
// //                     offset: Offset(0, 10),
// //                     color: Color(0xfff0f0f0),
// //                   )
// //                 ],
// //               );
// //             }
// //           }

// //           // Function to handle a user's answer selection
// //           void handleAnswerSelection(int answerIndex) {
// //             state(() {
// //               print(selectedAnswerIndex);
// //               print(question.options![answerIndex].id);
// //               selectedAnswerIndex = answerIndex;
// //             });
// //           }

// //           return Dialog(
// //             insetPadding: const EdgeInsets.all(10),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(22),
// //             ),
// //             child: Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                   color: Colors.white, borderRadius: BorderRadius.circular(22)),
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Question
// //                     Container(
// //                       decoration: defaultDecoration,
// //                       padding: const EdgeInsets.all(16),
// //                       child: Row(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             '${indexOfQuestion + 1}. ',
// //                             style: titleMedium.darkBG,
// //                           ),
// //                           Expanded(
// //                             child: Text(
// //                               question.question ?? '',
// //                               maxLines: 4,
// //                               style: titleMedium.darkBG,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const Gap(16),

// //                     // Answer options
// //                     for (int i = 0; i < question.options!.length; i++)
// //                       GestureDetector(
// //                         onTap: () {
// //                           handleAnswerSelection(i);
// //                         },
// //                         child: Container(
// //                           decoration:
// //                               dynamicDecoration(question.options?[i].id),
// //                           margin: const EdgeInsets.only(bottom: 16),
// //                           padding: const EdgeInsets.all(16),
// //                           child: Row(
// //                             children: [
// //                               CircleAvatar(
// //                                 backgroundColor: const Color(0xffEBEBEB),
// //                                 child: Text(
// //                                   String.fromCharCode('A'.codeUnitAt(0) + i),
// //                                   style: labelLarge.darkBG,
// //                                 ),
// //                               ),
// //                               const Gap(16),
// //                               Expanded(
// //                                 child: Text(
// //                                   question.options?[i].optionName ?? '',
// //                                   maxLines: 1,
// //                                   style: labelLarge.darkBG,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),

// //                     CustomOutlineButton(
// //                       'Continue to video',
// //                       onTap: (loader) {
// //                         Navigator.pop(context);
// //                         flickManager.flickControlManager!.autoResume();
// //                         bloc
// //                             .submitPopupQuestion(
// //                                 AppConstants.studentID ?? 0,
// //                                 question.id ?? 0,
// //                                 question.options?[selectedAnswerIndex!].id ?? 0)
// //                             .then((value) {
// //                           print('submit qstn $value');
// //                           // if(value){
// //                           SnackBarCustom.success(
// //                               value ? 'Correct answer' : 'Wrong answer');
// //                           flickManager.flickControlManager?.autoResume();
// //                           Navigator.pop(context);
// //                           // }
// //                         });
// //                       },
// //                       bgColor: ColorResources.secondary,
// //                       textColor: Colors.white,
// //                     ),
// //                     const Gap(13),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         }),
// //       );
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     flickManager.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<String?>(
// //       future: _getUrl(), // Use the _getUrl() method as the future
// //       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           // While fetching the video URL, display a loading indicator or placeholder
// //           return const Center(
// //               child:
// //                   CircularProgressIndicator()); // Replace with your loading widget
// //         } else if (snapshot.hasError) {
// //           // Handle errors while fetching the URL
// //           return const Text('Error fetching video URL');
// //         } else if (!snapshot.hasData || snapshot.data == null) {
// //           // Handle case where the video URL is not available
// //           return const Text('Video URL not found');
// //         } else if (snapshot.connectionState == ConnectionState.done) {
// //           // If the URL is fetched successfully, initialize the video player
// //           if (snapshot.data != null) {
// //             return AspectRatio(
// //               aspectRatio:
// //                   16 / 9, //if video is in full screen change the aspect ratio
// //               child: FlickVideoPlayer(
// //                 flickManager: flickManager,
// //                 flickVideoWithControls: FlickVideoWithControls(
// //                   videoFit: BoxFit.scaleDown,
// //                   controls:
// //                       CustomFlickPortraitControls(flickManager: flickManager),
// //                 ),
// //               ),
// //             );
// //           } else {
// //             return Container();
// //           }
// //         } else {
// //           return Container();
// //         }
// //       },
// //     );
// //   }
// // }

// // class _CustomPlayerState extends State<_CustomPlayer> {
// //   late FlickManager flickManager;
// //   MadrasaController bloc = MadrasaController();
// //   late String? url;
// //   String? tempTime;

// //   Future<String?> _getUrl() async {
// //     if (widget.model.mediaUrl == null) return null;
// //     try {
// //       url = await getUrl(widget.model.mediaUrl!);
// //       print('video url $url');
// //       setState(() {});
// //     } catch (e) {
// //       //
// //     }
// //     return null;
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     url = widget.model.url;
// //     _getUrl();
// //     print('initiate flick ${url}');
// //     flickManager = FlickManager(
// //       videoPlayerController: VideoPlayerController.networkUrl(
// //         Uri.parse(url ?? ''),
// //       ),
// //       onVideoEnd: () {
// //         print('vPlayer onVideoEnd');
// //       },
// //     );
// //     // initiateFlick();
// //     // Set up a listener for duration changes
// //     flickManager.flickVideoManager?.addListener(() {
// //       // Handle duration changes here
// //       print('video listerner');

// //       if (flickManager
// //           .flickVideoManager!.videoPlayerController!.value.hasError) {
// //         print(
// //             'Error occurred: ${flickManager.flickVideoManager?.videoPlayerController?.value.errorDescription}');
// //         // Handle the error here
// //       }

// //       if (flickManager
// //           .flickVideoManager!.videoPlayerController!.value.hasError) {
// //         print('vPlayer hasError');
// //         setState(() => _getUrl());
// //       }
// //       Duration currentDuration =
// //           flickManager.flickVideoManager!.videoPlayerController!.value.position;
// //       if (!(flickManager
// //           .flickVideoManager!.videoPlayerController!.value.isPlaying)) {
// //         currentDuration; //set this value to paused value and save to saved-duration
// //         if (DateConverter.durationToTime(currentDuration) != '00:00:00') {
// //           bloc
// //               .saveDuration(widget.model.id!,
// //                   DateConverter.durationToTime(currentDuration))
// //               .then((value) {
// //             print('duration save $value ');
// //           });
// //         }
// //       }

// //       widget.model.popupQuestion?.forEach((element) {
// //         print(
// //             'check quiz : ${element.duration} == ${DateConverter.durationToTime(currentDuration)} : ${element.duration == DateConverter.durationToTime(currentDuration)}');
// //         if (element.duration == DateConverter.durationToTime(currentDuration)) {
// //           print(
// //               'daetTimee !$tempTime == ${DateConverter.durationToTime(currentDuration)} : ${!(tempTime == DateConverter.durationToTime(currentDuration))} ');
// //           if (!(tempTime == DateConverter.durationToTime(currentDuration))) {
// //             tempTime = DateConverter.durationToTime(currentDuration);
// //             print('daetTimee ${DateConverter.durationToTime(currentDuration)}');
// //             element.questions?.forEach((question) {
// //               print('duration : $currentDuration ; ${element.duration}');
// //               flickManager.flickControlManager!.autoPause();
// //               print(
// //                   'add dur: $currentDuration + ${const Duration(seconds: 1)} = ${currentDuration + const Duration(seconds: 1)}');
// //               // if (question.options!.isEmpty) {
// //               //     flickManager.flickControlManager
// //               //         ?.seekForward(const Duration(milliseconds: 800));
// //               //   }
// //               openQuiz(question, element.questions!.indexOf(question),
// //                   currentDuration);
// //             });
// //           }
// //         }
// //       });
// //       //pause player first
// //       //  flickManager.flickControlManager!.playToggle();
// //       // show pop up questions
// //       //play again
// //     });
// //   }

// //   openQuiz(Question question, int indexOfQuestion, Duration currentDuration) {
// //     //open quiz
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       // var selectedAnswerIndex = -1;
// //       int? selectedAnswerIndex;
// //       // var correctAnswer = 1;

// //       // Show dialog
// //       showDialog(
// //         context: context,
// //         builder: (context) => StatefulBuilder(builder: (context, state) {
// //           // Function to define the decoration based on the selected and correct answers
// //           Decoration dynamicDecoration(int? id) {
// //             if (selectedAnswerIndex != null &&
// //                 question.options?[selectedAnswerIndex!].id == id) {
// //               return BoxDecoration(
// //                 color: ColorResources.primary, // Color for correct answer
// //                 borderRadius: BorderRadius.circular(8),
// //                 boxShadow: const [
// //                   BoxShadow(
// //                     blurRadius: 30,
// //                     spreadRadius: 0,
// //                     offset: Offset(0, 10),
// //                     color: Color(0xfff0f0f0),
// //                   )
// //                 ],
// //               );
// //             } else {
// //               return BoxDecoration(
// //                 color: Colors.white, // Default color
// //                 borderRadius: BorderRadius.circular(8),
// //                 boxShadow: const [
// //                   BoxShadow(
// //                     blurRadius: 30,
// //                     spreadRadius: 0,
// //                     offset: Offset(0, 10),
// //                     color: Color(0xfff0f0f0),
// //                   )
// //                 ],
// //               );
// //             }
// //           }

// //           // Function to handle a user's answer selection
// //           void handleAnswerSelection(int answerIndex) {
// //             state(() {
// //               print(selectedAnswerIndex);
// //               print(question.options![answerIndex].id);
// //               selectedAnswerIndex = answerIndex;
// //             });
// //           }

// //           return Dialog(
// //             insetPadding: const EdgeInsets.all(10),
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(22),
// //             ),
// //             child: Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                   color: Colors.white, borderRadius: BorderRadius.circular(22)),
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     // Question
// //                     Container(
// //                       decoration: defaultDecoration,
// //                       padding: const EdgeInsets.all(16),
// //                       child: Row(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             '${indexOfQuestion + 1}. ',
// //                             style: titleMedium.darkBG,
// //                           ),
// //                           Expanded(
// //                             child: Text(
// //                               question.question ?? '',
// //                               maxLines: 4,
// //                               style: titleMedium.darkBG,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const Gap(16),

// //                     // Answer options
// //                     for (int i = 0; i < question.options!.length; i++)
// //                       GestureDetector(
// //                         onTap: () {
// //                           handleAnswerSelection(i);
// //                         },
// //                         child: Container(
// //                           decoration:
// //                               dynamicDecoration(question.options?[i].id),
// //                           margin: const EdgeInsets.only(bottom: 16),
// //                           padding: const EdgeInsets.all(16),
// //                           child: Row(
// //                             children: [
// //                               CircleAvatar(
// //                                 backgroundColor: const Color(0xffEBEBEB),
// //                                 child: Text(
// //                                   String.fromCharCode('A'.codeUnitAt(0) + i),
// //                                   style: labelLarge.darkBG,
// //                                 ),
// //                               ),
// //                               const Gap(16),
// //                               Expanded(
// //                                 child: Text(
// //                                   question.options?[i].optionName ?? '',
// //                                   maxLines: 1,
// //                                   style: labelLarge.darkBG,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),

// //                     CustomOutlineButton(
// //                       'Continue to video',
// //                       onTap: (loader) {
// //                         Navigator.pop(context);
// //                         flickManager.flickControlManager!.autoResume();
// //                         bloc
// //                             .submitPopupQuestion(
// //                                 AppConstants.studentID ?? 0,
// //                                 question.id ?? 0,
// //                                 question.options?[selectedAnswerIndex!].id ?? 0)
// //                             .then((value) {
// //                           print('submit qstn $value');
// //                           // if(value){
// //                           SnackBarCustom.success(
// //                               value ? 'Correct answer' : 'Wrong answer');
// //                           flickManager.flickControlManager?.autoResume();
// //                           Navigator.pop(context);
// //                           // }
// //                         });
// //                       },
// //                       bgColor: ColorResources.secondary,
// //                       textColor: Colors.white,
// //                     ),
// //                     // const Gap(16),
// //                     // Center(
// //                     //   child: Text(
// //                     //     (selectedAnswerIndex == -1)
// //                     //         ? 'Select an answer'
// //                     //         : (question.options?[selectedAnswerIndex].isCorrect == 1)
// //                     //             ? 'Correct answer'
// //                     //             : 'Wrong answer',
// //                     //     style: (selectedAnswerIndex == -1)
// //                     //         ? bodyMedium.primary
// //                     //         : (question.options?[selectedAnswerIndex].isCorrect == 1)
// //                     //             ? bodyMedium.primary
// //                     //             : bodyMedium.red,
// //                     //     textAlign: TextAlign.center,
// //                     //   ),
// //                     // ),
// //                     const Gap(13),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         }),
// //       );
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     flickManager.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return FlickVideoPlayer(
// //       flickManager: flickManager,
// //       flickVideoWithControls: FlickVideoWithControls(
// //         controls: CustomFlickPortraitControls(flickManager: flickManager),
// //       ),
// //     );
// //   }
// // }

// /// Default portrait controls.
// class CustomFlickPortraitControls extends StatelessWidget {
//   const CustomFlickPortraitControls(
//       {super.key,
//       this.iconSize = 20,
//       this.fontSize = 12,
//       this.progressBarSettings,
//       required this.flickManager});
//   final FlickManager flickManager;

//   /// Icon size.
//   ///
//   /// This size is used for all the player icons.
//   final double iconSize;

//   /// Font size.
//   ///
//   /// This size is used for all the text.
//   final double fontSize;

//   /// [FlickProgressBarSettings] settings.
//   final FlickProgressBarSettings? progressBarSettings;

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<VideoSpeedProvider>(context, listen: false)
//         .makeCurrentSpeedDefault(
//             flickmanager: flickManager.flickControlManager);
//     return Stack(
//       children: <Widget>[
//         Positioned.fill(
//           child: FlickShowControlsAction(
//             child: FlickSeekVideoAction(
//               child: Center(
//                 child: FlickVideoBuffer(
//                   child: FlickAutoHideChild(
//                     showIfVideoNotInitialized: false,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           '5s',
//                           style: labelMedium.primary,
//                         ),
//                         const Gap(10),
//                         Container(
//                           height: 30,
//                           width: 30,
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                               color: Colors.white70,
//                               borderRadius: BorderRadius.circular(100)),
//                           child: RotatedBox(
//                               quarterTurns: 2,
//                               child: Assets.svgs.forward
//                                   .svg(color: ColorResources.primary)),
//                         ),
//                         const Gap(10),
//                         FlickPlayToggle(
//                           // size: 40,
//                           color: ColorResources.primary,
//                           playChild: Assets.svgs.videoPlay
//                               .svg(color: ColorResources.primary),

//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white70,
//                             borderRadius: BorderRadius.circular(40),
//                           ),
//                         ),
//                         const Gap(10),
//                         Container(
//                           height: 30,
//                           width: 30,
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                               color: Colors.white70,
//                               borderRadius: BorderRadius.circular(100)),
//                           child: Assets.svgs.forward
//                               .svg(color: ColorResources.primary),
//                         ),
//                         const Gap(10),
//                         Text(
//                           '5s',
//                           style: labelMedium.primary,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         FlickAutoHideChild(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 FlickVideoProgressBar(
//                   flickProgressBarSettings: progressBarSettings,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     RotatedBox(
//                       quarterTurns: 2,
//                       child: Assets.svgs.forward.svg(),
//                     ),
//                     const Gap(12),
//                     FlickPlayToggle(
//                       size: iconSize,
//                       color: ColorResources.WHITE,
//                       playChild: Assets.svgs.videoPlay.svg(),
//                     ),
//                     const Gap(12),
//                     Assets.svgs.forward.svg(),
//                     const Spacer(),
//                     Row(
//                       children: <Widget>[
//                         FlickAutoHideChild(
//                           child: Consumer<VideoSpeedProvider>(
//                               builder: (context, controller, _) {
//                             return CupertinoButton(
//                               onPressed: () async {
//                                 controller.onCurrentSpeedUpdate();
//                                 await flickManager.flickControlManager
//                                     ?.setPlaybackSpeed(controller.currentSpeed);
//                               },
//                               padding: EdgeInsets.zero,
//                               minSize: 0,
//                               child: Container(
//                                 width: 35,
//                                 height: 15,
//                                 decoration: BoxDecoration(
//                                     color: ColorResources.primary,
//                                     borderRadius: BorderRadius.circular(5)),
//                                 child: Center(
//                                   child: Text(
//                                     '${controller.currentSpeed} x   ',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: fontSize,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                         Gap(10),
//                         FlickCurrentPosition(
//                           fontSize: fontSize,
//                         ),
//                         FlickAutoHideChild(
//                           child: Text(
//                             ' / ',
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: fontSize),
//                           ),
//                         ),
//                         FlickTotalDuration(
//                           fontSize: fontSize,
//                         ),
//                       ],
//                     ),
//                     const Gap(14),
//                     FlickFullScreenToggle(
//                       size: iconSize,
//                       enterFullScreenChild: Assets.svgs.fullscreen.svg(),
//                       exitFullScreenChild: Assets.svgs.fullscreen.svg(),
//                       padding: EdgeInsets.zero,
//                       toggleFullscreen: () {
//                         DashboardController.i.toggleNavBarVisibility();
//                         flickManager.flickControlManager?.toggleFullscreen();
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
