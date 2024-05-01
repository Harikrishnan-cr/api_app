class ChapterDetailsJsonModel {
  bool? status;
  ChapterDetailsModel? data;
  String? message;

  ChapterDetailsJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory ChapterDetailsJsonModel.fromJson(Map<String, dynamic> json) =>
      ChapterDetailsJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : ChapterDetailsModel.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class ChapterDetailsModel {
  LessonDetail? lessonDetail;

  ChapterDetailsModel({
    this.lessonDetail,
  });

  factory ChapterDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChapterDetailsModel(
        lessonDetail: json["lessonDetail"] == null
            ? null
            : LessonDetail.fromJson(json["lessonDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "lessonDetail": lessonDetail?.toJson(),
      };
}

class LessonDetail {
  int? id;
  String? lessonId;
  String? title;
  String? subTitle;
  int? isActive;
  String? description;
  String? photoUrl;
  String? mediaUrl;
  List<Material>? materials;

  LessonDetail({
    this.id,
    this.lessonId,
    this.title,
    this.subTitle,
    this.isActive,
    this.description,
    this.photoUrl,
    this.mediaUrl,
    this.materials,
  });

  factory LessonDetail.fromJson(Map<String, dynamic> json) => LessonDetail(
        id: json["id"],
        lessonId: json["lessonId"],
        title: json["title"],
        subTitle: json["subTitle"],
        isActive: json["isActive"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        mediaUrl: json["mediaUrl"],
        materials: json["materials"] == null
            ? []
            : List<Material>.from(
                json["materials"]!.map((x) => Material.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lessonId": lessonId,
        "title": title,
        "subTitle": subTitle,
        "isActive": isActive,
        "description": description,
        "photoUrl": photoUrl,
        "mediaUrl": mediaUrl,
        "materials": materials == null
            ? []
            : List<dynamic>.from(materials!.map((x) => x.toJson())),
      };
}

class Material {
  int? id;
  String? mediaUrl;
  String? materialDetails;
  String? materialType;
  dynamic isFree;
  dynamic videoDuration;
  dynamic isEnabled;

  Material({
    this.id,
    this.mediaUrl,
    this.materialDetails,
    this.materialType,
    this.isFree,
    this.videoDuration,
    this.isEnabled,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json["id"],
        mediaUrl: json["mediaUrl"],
        materialDetails: json["materialDetails"],
        materialType: json["materialType"],
        isFree: json["isFree"],
        videoDuration: json["videoDuration"],
        isEnabled: json["isEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mediaUrl": mediaUrl,
        "materialDetails": materialDetails,
        "materialType": materialType,
        "isFree": isFree,
        "videoDuration": videoDuration,
        "isEnabled": isEnabled,
      };
}
