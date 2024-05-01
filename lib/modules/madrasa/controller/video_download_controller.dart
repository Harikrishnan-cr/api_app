import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/core/video_local_storage.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/courses/models/course_chapters_model.dart';
import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/madrasa/models/video_download_modal.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:uuid/uuid.dart';

class VideoDownloadController extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  late List<File> videoFiles = [];
  // VideoDownloadController() {}
  String progressString = '';
  Future<void> downloadFile(
      String? videoUrl, LessonMediaModel lessonModel) async {
    // log('materila id is ${lessonModel.type}');
    // if (videoUrl == null) return;
    if (videoUrl == null) return;
    Dio dio = Dio();
    var uuid = const Uuid().v1();
    try {
      lessonModel.isDownloadStarted = true;

      notifyListeners();

      var dir = await getApplicationDocumentsDirectory();
      //"${dir.path}/samastha-$uuid.mp4"
// "${dir.path}/samastha-userid-${AppConstants.loggedUser?.id}-${AppConstants.loggedUser?.name}$uuid.mp4"

      final String downlaodPath =
          '${dir.path}/samastha-userid-${AppConstants.loggedUser?.id}-$uuid.mp4';
      await dio.download(videoUrl, downlaodPath,
          // "${dir.path}/samastha-userid-${AppConstants.loggedUser?.id}-$uuid.mp4",
          onReceiveProgress: (rec, total) {
        progressString = "${((rec / total) * 100).toStringAsFixed(0)}%";

        notifyListeners();

        // setState(() {
        // downloading = true;
        // progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        //});
      }).whenComplete(() async {
        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        List<FileSystemEntity> files = appDocumentsDirectory.listSync();

        final loaclaFile =
            await VideoDownlaodLocalClass.getAllLocalVidoeFiles();

        for (FileSystemEntity file in files) {
          log('all files is ${files}');
          if (file is File &&
              file.path.endsWith('.mp4') &&
              file.path
                  .contains(AppConstants.loggedUser?.id.toString() ?? '0')) {
            log('filepaths ${file.path}');
            if (file.path == downlaodPath) {
              await Dio()
                  .get<Uint8List>(
                      lessonModel.thumbnailUrl ??
                          'https://www.islamicity.org/global/images/photo/IC-Articles/boys-study-quran__1024x683.JPG',
                      options: Options(responseType: ResponseType.bytes))
                  .then((value) {
                log('befor save called $value');
                VideoDownlaodLocalClass.addToLocalStorage(
                    videoListData: VideoDownlaodModelClass(
                        materilaID: lessonModel.id ?? 0,
                        deviceID: '',
                        discription: lessonModel.description ?? '',
                        dowlaodPath: file.path,
                        thumbanailUrl: lessonModel.thumbnailUrl ?? '',
                        title: lessonModel.title ?? '',
                        userId: AppConstants.loggedUser?.id ?? 0,
                        videoDuration: lessonModel.videoDuration ?? '',
                        // vidoeUrlPath: file,
                        thumbImgMemory: value.data
                        // materialId: lessonModel.id ?? 0,
                        // path: downlaodPath,
                        // title: lessonModel.title ?? '',
                        // videoUrlpath: file,
                        // uniqId: uuid,
                        // imagePath: value.data,
                        // userId: AppConstants.loggedUser?.id ?? 0

                        ));
              });
            }

            // final data = loaclaFile?.where((element) {
            //   return element.path == file.path;
            // }).toList();

            // for (int i = 0; i < (data?.length ?? 0); i++) {
            //   log('filepaths local ${data?[i].path}');
            // }
            // videoFiles.add(file);

            // /controllers.add(VideoPlayerController.file(file)..initialize());
          }
        }
        // VideoDownlaodLocalClass.addtoLocalStoarge(
        //     vidoeListData: VidoeDownloadModelGetClass(
        //         materialId: lessonModel.id ?? 0,
        //         path: downlaodPath,
        //         title: lessonModel.title ?? '',
        //         uniqId: uuid,
        //         imagePath: '',
        //         userId: AppConstants.loggedUser?.id ?? 0));
        log('materila download path is $downlaodPath');
        downloadStarted(
            downloadPath: downlaodPath,
            materialID: lessonModel.id.toString() ?? '0',
            typeOf: '');
        progressString = '';
        lessonModel.isDownloadStarted = false;

        notifyListeners();
      });
    } catch (e) {
      progressString = '';
      lessonModel.isDownloadStarted = false;

      notifyListeners();
      print(e);
    }

    // setState(() {
    // downloading = false;
    // progressString = "Completed";
    // });
    print("Download completed");
  }

  Future<void> downloadFileCources(String? videoUrl, Lesson lessonModel) async {
    if (videoUrl == null) return;
    Dio dio = Dio();
    var uuid = const Uuid().v1();
    try {
      lessonModel.isDownloadStarted = true;

      notifyListeners();

      var dir = await getApplicationDocumentsDirectory();

      final String downlaodPath =
          '${dir.path}/samastha-userid-${AppConstants.loggedUser?.id}-$uuid.mp4';
      await dio.download(videoUrl, downlaodPath,
          onReceiveProgress: (rec, total) {
        progressString = "${((rec / total) * 100).toStringAsFixed(0)}%";

        notifyListeners();
      }).whenComplete(() async {
        Directory appDocumentsDirectory =
            await getApplicationDocumentsDirectory();
        List<FileSystemEntity> files = appDocumentsDirectory.listSync();

        final loaclaFile =
            await VideoDownlaodLocalClass.getAllLocalVidoeFiles();

        for (FileSystemEntity file in files) {
          log('all files is ${files}');
          if (file is File &&
              file.path.endsWith('.mp4') &&
              file.path
                  .contains(AppConstants.loggedUser?.id.toString() ?? '0')) {
            log('filepaths ${file.path}');
            if (file.path == downlaodPath) {
              await Dio()
                  .get<Uint8List>(
                      lessonModel.thumbnailUrl ??
                          'https://www.islamicity.org/global/images/photo/IC-Articles/boys-study-quran__1024x683.JPG',
                      options: Options(responseType: ResponseType.bytes))
                  .then((value) {
                log('befor save called $value');
                VideoDownlaodLocalClass.addToLocalStorage(
                    videoListData: VideoDownlaodModelClass(
                        materilaID: lessonModel.id ?? 0,
                        deviceID: '',
                        discription: lessonModel.description ?? '',
                        dowlaodPath: file.path,
                        thumbanailUrl: lessonModel.thumbnailUrl ?? '',
                        title: lessonModel.title ?? '',
                        userId: AppConstants.loggedUser?.id ?? 0,
                        videoDuration: lessonModel.courseDuration ?? '',
                        thumbImgMemory: value.data));
              });
            }
          }
        }

        log('materila download path is $downlaodPath');
        downloadStarted(
            isCourse: true,
            downloadPath: downlaodPath,
            materialID: lessonModel.id.toString() ?? '0',
            typeOf: '');
        progressString = '';
        lessonModel.isDownloadStarted = false;

        notifyListeners();
      });
    } catch (e) {
      progressString = '';
      lessonModel.isDownloadStarted = false;

      notifyListeners();
      print(e);
    }
  }

  void downloadStarted(
      {required String downloadPath,
      required String materialID,
      required String typeOf,
      bool isCourse = false}) {
    try {
      dioClient.post(Urls.offlineDownload, data: {
        "download_path": downloadPath,
        "material_id": materialID,
        "device_id": "1111",
        "type": isCourse ? 'course' : "subject"
      }).whenComplete(() async {
        // final box = GetStorage();

        try {
          await dioClient.get(Urls.getofflineDownloa).then((value) {});
        } catch (e) {
          log('get downloaded vidoe is error $e');
        }
      });
    } catch (e) {
      SnackBarCustom.success('Error:- $e');
    }
  }
}
