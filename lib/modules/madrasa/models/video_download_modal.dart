import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'video_download_modal.g.dart';

@HiveType(typeId: 1)
class VideoDownlaodModelClass {
  @HiveField(0)
  String dowlaodPath;

  @HiveField(1)
  String thumbanailUrl;

  @HiveField(2)
  String title;

  @HiveField(3)
  String discription;

  @HiveField(4)
  String videoDuration;

  @HiveField(5)
  int userId;

  @HiveField(6)
  String deviceID;

  // @HiveField(7)
  // File vidoeUrlPath;

  @HiveField(8)
  Uint8List? thumbImgMemory;

  @HiveField(9)
  int materilaID;

  VideoDownlaodModelClass({
    required this.discription,
    this.thumbImgMemory,
    // required this.vidoeUrlPath,
    required this.dowlaodPath,
    required this.materilaID,
    required this.deviceID,
    required this.videoDuration,
    required this.thumbanailUrl,
    required this.userId,
    required this.title,
  });
}
