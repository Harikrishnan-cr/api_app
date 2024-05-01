import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samastha/core/app_constants.dart';

import 'package:samastha/core/video_local_storage.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/madrasa/models/video_download_modal.dart';
import 'package:video_player/video_player.dart';

class GetLocalVideoController extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  late List<File> videoFiles = [];
  late List<VideoPlayerController> controllers = [];

  List<VideoDownlaodModelClass>? loaclaFile = [];

  // Future<void> loadAllLocalVideos() async {
  //   videoFiles.clear();
  //   controllers.clear();
  //   Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  //   List<FileSystemEntity> files = appDocumentsDirectory.listSync();

  //   // final loaclaFile = VideoDownlaodLocalClass.getAllLocalVidoeFiles();

  //   for (FileSystemEntity file in files) {
  //     log('all files is ${files}');
  //     if (file is File &&
  //         file.path.endsWith('.mp4') &&
  //         file.path.contains(AppConstants.loggedUser?.id.toString() ?? '0')) {
  //       log('filepaths ${file.path}');

  //       // final data = loaclaFile?.where((element) {
  //       //   return element.path == file.path;
  //       // }).toList();

  //       // for (int i = 0; i < (data?.length ?? 0); i++) {
  //       //   log('filepaths local ${data?[i].path}');
  //       // }
  //       videoFiles.add(file);

  //       // /controllers.add(VideoPlayerController.file(file)..initialize());
  //     }
  //   }

  //   notifyListeners();
  // }

  void getLoaclVideos() async {
    loaclaFile?.clear();

    final dataList = await VideoDownlaodLocalClass.getAllLocalVidoeFiles();
    List<VideoDownlaodModelClass>? userDataList = [];

    userDataList.clear();
    for (int i = 0; i < (dataList?.length ?? 0); i++) {
      if (dataList![i]
          .dowlaodPath
          .contains((AppConstants.loggedUser?.id.toString() ?? '0'))) {
        userDataList.add(dataList[i]);
      }
    }

    loaclaFile?.addAll(userDataList);

    notifyListeners();
    // loaclaFile?.clear();
    // if (VideoDownlaodLocalClass.getAllLocalVidoeFiles() != null &&
    //     VideoDownlaodLocalClass.getAllLocalVidoeFiles()!.isNotEmpty) {
    //   loaclaFile?.addAll(VideoDownlaodLocalClass.getAllLocalVidoeFiles()!);
    //   log('local videos is ${loaclaFile?.length}');
    //   // notifyListeners();
    // }
  }

  void onDispose() {
    for (VideoPlayerController controller in controllers) {
      controller.dispose();
    }
  }
}
