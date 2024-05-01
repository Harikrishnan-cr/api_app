import 'dart:convert';

import 'package:samastha/modules/courses/models/course_chapters_model.dart';

LessonMediaModel lessonMediaModelFromJson(String str) =>
    LessonMediaModel.fromJson(json.decode(str));

String lessonMediaModelToJson(LessonMediaModel data) =>
    json.encode(data.toJson());

class LessonMediaModel {
  final int? id;
  final String? mediaUrl;
  final String? type;
  final String? videoDuration;
  final String? materialDetails;
  final int? isFree;
  final String? url;
  final List<PopupQuestion>? popupQuestion;
  final List<Media>? media;
  bool? isDownloadStarted;
  final String? thumbnailUrl;

  final String? title, description, subtitle;
  final String? downloadedStatus;

  LessonMediaModel(
      {this.id,
      this.mediaUrl,
      this.type,
      this.isDownloadStarted = false,
      this.videoDuration,
      this.materialDetails,
      this.isFree,
      this.url,
      this.popupQuestion,
      this.media,
      this.description,
      this.title,
      this.downloadedStatus,
      this.thumbnailUrl,
      this.subtitle});

  factory LessonMediaModel.fromJson(Map<String, dynamic> json) => LessonMediaModel(
      id: json["id"],
      mediaUrl: json["type"].toString().toLowerCase() == 'video'.toLowerCase()
          ? json["videoUrl"]
          : json["mediaUrl"],
      title: json["title"],
      description: json["subTitle"],
      subtitle: json["subTitle"],
      type: json["type"],
      downloadedStatus: json["downloadedStatus"],
      videoDuration: json["videoDuration"] == null
          ? null
          : convertDuration(json["videoDuration"]),
      materialDetails: json["materialDetails"],
      isFree: json["isFree"],
      url: json["url"] ??
          'https://file-examples.com/storage/fe7b7e0dc465e22bc9e6da8/2017/04/file_example_MP4_480_1_5MG.mp4',
      popupQuestion: json["popupQuestion"] == null
          ? []
          : List<PopupQuestion>.from(
              json["popupQuestion"]!.map((x) => PopupQuestion.fromJson(x))),
      media: json["media"] == null
          ? []
          : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      thumbnailUrl: json['photoUrl'] ??
          'https://i.ytimg.com/vi/BolYvL35UaA/hqdefault.jpg');

  Map<String, dynamic> toJson() => {
        "id": id,
        "mediaUrl": mediaUrl,
        "type": type,
        "videoDuration": videoDuration,
        "materialDetails": materialDetails,
        "isFree": isFree,
        "downloadedStatus": downloadedStatus,
        "subTitle": subtitle,
        "url": url,
        "popupQuestion": popupQuestion == null
            ? []
            : List<dynamic>.from(popupQuestion!.map((x) => x)),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Media {
  final int? id;
  final String? modelType;
  final int? modelId;
  final String? uuid;
  final String? collectionName;
  final String? name;
  final String? fileName;
  final String? mimeType;
  final String? disk;
  final String? conversionsDisk;
  final int? size;
  final List<dynamic>? manipulations;
  final List<dynamic>? customProperties;
  final List<dynamic>? generatedConversions;
  final List<dynamic>? responsiveImages;
  final int? orderColumn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? originalUrl;
  final String? previewUrl;

  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.uuid,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.conversionsDisk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.generatedConversions,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.originalUrl,
    this.previewUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["modelType"],
        modelId: json["modelId"],
        uuid: json["uuid"],
        collectionName: json["collectionName"],
        name: json["name"],
        fileName: json["fileName"],
        mimeType: json["mimeType"],
        disk: json["disk"],
        conversionsDisk: json["conversionsDisk"],
        size: json["size"],
        manipulations: json["manipulations"] == null
            ? []
            : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
        customProperties: json["customProperties"] == null
            ? []
            : List<dynamic>.from(json["customProperties"]!.map((x) => x)),
        generatedConversions: json["generatedConversions"] == null
            ? []
            : List<dynamic>.from(json["generatedConversions"]!.map((x) => x)),
        responsiveImages: json["responsiveImages"] == null
            ? []
            : List<dynamic>.from(json["responsiveImages"]!.map((x) => x)),
        orderColumn: json["orderColumn"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        originalUrl: json["originalUrl"],
        previewUrl: json["previewUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modelType": modelType,
        "modelId": modelId,
        "uuid": uuid,
        "collectionName": collectionName,
        "name": name,
        "fileName": fileName,
        "mimeType": mimeType,
        "disk": disk,
        "conversionsDisk": conversionsDisk,
        "size": size,
        "manipulations": manipulations == null
            ? []
            : List<dynamic>.from(manipulations!.map((x) => x)),
        "customProperties": customProperties == null
            ? []
            : List<dynamic>.from(customProperties!.map((x) => x)),
        "generatedConversions": generatedConversions == null
            ? []
            : List<dynamic>.from(generatedConversions!.map((x) => x)),
        "responsiveImages": responsiveImages == null
            ? []
            : List<dynamic>.from(responsiveImages!.map((x) => x)),
        "orderColumn": orderColumn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "originalUrl": originalUrl,
        "previewUrl": previewUrl,
      };
}

String convertDuration(String duration) {
  // Assuming the input duration is in the format "00:00:02"
  List<String> parts = duration.split(':');

  // Parse hours, minutes, and seconds
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2]);

  // Format the result based on hours, minutes, and seconds
  if (hours > 0) {
    // Output as "01h 30m 34s"
    return '${hours}h ${minutes}m ${seconds}s';
  } else if (minutes > 0) {
    // Output as "30m 34s"
    return '${minutes}m ${seconds}s';
  } else {
    // Output as "34s"
    return '${seconds}s';
  }
}
