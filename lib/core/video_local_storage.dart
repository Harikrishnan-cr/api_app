import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:samastha/core/app_constants.dart';

import 'package:samastha/modules/madrasa/models/video_download_modal.dart';

class VideoDownlaodLocalClass {
  static void addToLocalStorage(
      {required VideoDownlaodModelClass videoListData}) async {
    log('save called');
    final hiveBox = await Hive.openBox<VideoDownlaodModelClass>(
        AppConstants.hiveStorageKey);

    try {
      await hiveBox.put(videoListData.materilaID, videoListData).then((value) {
        log('save to local storage id is ');
      });
    } catch (e) {
      log('not save to local error $e');
    }
  }

//   static void addtoLocalStoarge(
//       {required VideoDownlaodModelClass vidoeListData}) async {
//     log('saved cllaed');
//     final hivebox = await Hive.openBox<VideoDownlaodModelClass>(
//         AppConstants.hiveStorageKey);

//     try {
//       await hivebox.put(vidoeListData.materilaID, vidoeListData).then((value) {
//         log('saved to local storage id is ');
//       });
//     } catch (e) {
//       log('not saved to local error $e');
//     }
//     // final box = GetStorage();
//     // List<VideoDownlaodModelClass> localVideoList = [];

//     // localVideoList.clear();

//     // if (box.read<List<VidoeDownloadModelGetClass>>(
//     //             AppConstants.getStorageKey) !=
//     //         null &&
//     //     box
//     //         .read<List<VidoeDownloadModelGetClass>>(AppConstants.getStorageKey)!
//     //         .isNotEmpty) {
//     //   localVideoList.addAll(box
//     //       .read<List<VidoeDownloadModelGetClass>>(AppConstants.getStorageKey)!);
//     // }

// // if(hivebox.values != null)

//     // if (!localVideoList.contains(vidoeListData)) {
//     //   localVideoList.add(vidoeListData);
//     // }

//     try {
//       await hivebox.put(vidoeListData.materilaID, vidoeListData).then((value) {
//         log('saved to local storage id is ');
//       });
//     } catch (e) {
//       log('not saved to local error $e');
//     }
//     // final ddd = hivebox.values.toList();
//     // log(hivebox.values.toList().toString());
//     // await box.write(AppConstants.getStorageKey, localVideoList);

//     //VidoeDownloadModelGetClass
//   }

  static Future<List<VideoDownlaodModelClass>>? getAllLocalVidoeFiles() async {
    final hivebox = await Hive.openBox<VideoDownlaodModelClass>(
        AppConstants.hiveStorageKey);

    return hivebox.values.toList();

    // log('data iis ${box.read(AppConstants.getStorageKey)}');
    // return box
    //     .read<List<VidoeDownloadModelGetClass>>(AppConstants.getStorageKey);
  }

  static Future<void> deleteLocalVidoe(int meaterialID) async {
    final hivebox = await Hive.openBox<VideoDownlaodModelClass>(
        AppConstants.hiveStorageKey);

    await hivebox.delete(meaterialID);
  }

  void closeive() async {
    final hivebox = await Hive.openBox<VideoDownlaodModelClass>(
        AppConstants.hiveStorageKey);

    await hivebox.close();
  }
}
