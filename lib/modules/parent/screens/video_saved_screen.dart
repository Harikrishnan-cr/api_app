import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samastha/core/video_local_storage.dart';
import 'package:samastha/modules/courses/screens/thumbnail_item.dart';
import 'package:samastha/modules/parent/controller/get_local_videos_controller.dart';
import 'package:samastha/modules/parent/screens/local_flic_video_payer.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/widgets/app_bars_custom.dart';

class SavedVideoScreen extends StatefulWidget {
  const SavedVideoScreen({super.key});
  static const String path = '/saved-video-screeen';

  @override
  State<SavedVideoScreen> createState() => _SavedVideoScreenState();
}

class _SavedVideoScreenState extends State<SavedVideoScreen> {
  // late List<File> _videoFiles = [];
  // late List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    Provider.of<GetLocalVideoController>(context, listen: false)
        .getLoaclVideos();
    //_loadVideos();
  }

  // Future<void> _loadVideos() async {
  //   Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  //   List<FileSystemEntity> files = appDocumentsDirectory.listSync();

  //   for (FileSystemEntity file in files) {
  //     if (file is File && file.path.endsWith('.mp4')) {
  //       _videoFiles.add(file);
  //       _controllers.add(VideoPlayerController.file(file)..initialize());
  //     }
  //   }

  //   setState(() {});
  // }

  // void onPrint() {
  //   for (int i = 0; i < _controllers.length; i++) {
  //     // log('file path ${_controllers[i].dataSource}');
  //   }
  // }

  @override
  void dispose() {
    // Provider.of<GetLocalVideoController>(context, listen: false).onDispose();
    // for (VideoPlayerController controller in _controllers) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  //  Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) => LocalVideoPlayerScreen(
  //                                   currentIndex: index,
  //                                   videoUrlLocalPath: _videoFiles[index].path,
  //                                 )),
  //                       );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Downloads'),
      body:
          Consumer<GetLocalVideoController>(builder: (context, controller, _) {
        return SafeArea(
            child: controller.loaclaFile != null &&
                    controller.loaclaFile!.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.loaclaFile?.length,
                    itemBuilder: (context, index) {
                      log('vidoe url paths is ${controller.loaclaFile?[index].dowlaodPath}');
                      return LocalVideoThumb(
                          materialId:
                              controller.loaclaFile?[index].materilaID ?? 0,
                          sharkImage:
                              controller.loaclaFile?[index].thumbImgMemory,
                          deleteUrlFilePath: File(
                              controller.loaclaFile?[index].dowlaodPath ?? ''),
                          onTap: () async {
                            //  controller.loadAllLocalVideos();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalVideoPlayerScreen(
                                        currentIndex: index,
                                        videoUrlLocalPath: controller
                                            .loaclaFile?[index].dowlaodPath,
                                      )),
                            );
                          },
                          time: controller.loaclaFile?[index].videoDuration ??
                              '1',
                          title: controller.loaclaFile?[index].title ?? '');

                      // ListTile(
                      //   title: Text('Video ${index + 1}'),
                      //   onTap: () async {
                      //     log('message url is ${_videoFiles[index].path}');
                      //     // String udid = await FlutterUdid.consistentUdid;
                      //     // log('path for the vieos ${generateRandomUniqueId()}');
                      //     //73c23b1c01b96213ded48bb8b00e1186b8d48cf709353150b8aa79fd4fb09d96
                      //     // log('unique udid in flutter is $udid');

                      //   },
                      // );
                    },
                  )
                : Center(
                    child: Text('No Downloads',
                        style: button.copyWith(
                          color: ColorResources.BLACKGREY,
                        )),
                  ));
      }),
    );
  }
}
