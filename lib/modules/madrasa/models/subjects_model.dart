 // To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) => SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
    final int? id;
    final String? photoUrl;
    final String? title;
    final String? description;
    final String? subjectDisplayId;
    final dynamic image;
    final dynamic signedPhotoUrl;
    final List<dynamic>? media;

    SubjectModel({
        this.id,
        this.photoUrl,
        this.title,
        this.description,
        this.subjectDisplayId,
        this.image,
        this.signedPhotoUrl,
        this.media,
    });

    factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json["id"],
        photoUrl: json["photoUrl"],
        title: json["title"],
        description: json["description"],
        subjectDisplayId: json["subjectDisplayId"],
        image: json["image"],
        signedPhotoUrl: json["signedPhotoUrl"],
        media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photoUrl": photoUrl,
        "title": title,
        "description": description,
        "subjectDisplayId": subjectDisplayId,
        "image": image,
        "signedPhotoUrl": signedPhotoUrl,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
    };
}




class SubjectDetailsModel {
    final SubjectDetails? subjectDetails;
    final List<Lesson>? lessons;

    SubjectDetailsModel({
        this.subjectDetails,
        this.lessons,
    });

    factory SubjectDetailsModel.fromJson(Map<String, dynamic> json) => SubjectDetailsModel(
        subjectDetails: json["subjectDetails"] == null ? null : SubjectDetails.fromJson(json["subjectDetails"]),
        lessons: json["lessons"] == null ? [] : List<Lesson>.from(json["lessons"]!.map((x) => Lesson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subjectDetails": subjectDetails?.toJson(),
        "lessons": lessons == null ? [] : List<dynamic>.from(lessons!.map((x) => x.toJson())),
    };
}

class Lesson {
    final int? id;
    final String? lessonDisplayId;
    final String? title;
    final String? description;
    final String? subTitle;
    final String? photoUrl;
    final int? isActive;
    final List<Material>? materials;
    final List<dynamic>? media;

    final String? videoDuration;

    Lesson({
        this.id,
        this.lessonDisplayId,
        this.title,
        this.description,
        this.subTitle,
        this.photoUrl,
        this.isActive,
        this.materials,
        this.media,
        this.videoDuration
    });

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        lessonDisplayId: json["lessonDisplayId"],
        title: json["title"],
        description: json["description"],
        subTitle: json["subTitle"],
        photoUrl: json["photoUrl"],
        isActive: json["isActive"],
        materials: json["materials"] == null ? [] : List<Material>.from(json["materials"]!.map((x) => Material.fromJson(x))),
        media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lessonDisplayId": lessonDisplayId,
        "title": title,
        "description": description,
        "subTitle": subTitle,
        "photoUrl": photoUrl,
        "isActive": isActive,
        "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x.toJson())),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
    };
}

class Material {
    final int? id;
    final String? materialType;
    final String? materialDetails;
    final int? fkSubjectId;
    final int? createdBy;
    final int? updatedBy;
    final int? isEnabled;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? mediaUrl;
    final String? videoDuration;
    final int? fkSubjectLessonId;
    final int? isFree;
    final String? signedMediaUrl;
    final List<Media>? media;

    Material({
        this.id,
        this.materialType,
        this.materialDetails,
        this.fkSubjectId,
        this.createdBy,
        this.updatedBy,
        this.isEnabled,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.mediaUrl,
        this.videoDuration,
        this.fkSubjectLessonId,
        this.isFree,
        this.signedMediaUrl,
        this.media,
    });

    factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json["id"],
        materialType: json["materialType"],
        materialDetails: json["materialDetails"],
        fkSubjectId: json["fkSubjectId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isEnabled: json["isEnabled"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        mediaUrl: json["mediaUrl"],
        videoDuration: json["videoDuration"],
        fkSubjectLessonId: json["fkSubjectLessonId"],
        isFree: json["isFree"],
        signedMediaUrl: json["signedMediaUrl"],
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "materialType": materialType,
        "materialDetails": materialDetails,
        "fkSubjectId": fkSubjectId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isEnabled": isEnabled,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "mediaUrl": mediaUrl,
        "videoDuration": videoDuration,
        "fkSubjectLessonId": fkSubjectLessonId,
        "isFree": isFree,
        "signedMediaUrl": signedMediaUrl,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
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
        manipulations: json["manipulations"] == null ? [] : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
        customProperties: json["customProperties"] == null ? [] : List<dynamic>.from(json["customProperties"]!.map((x) => x)),
        generatedConversions: json["generatedConversions"] == null ? [] : List<dynamic>.from(json["generatedConversions"]!.map((x) => x)),
        responsiveImages: json["responsiveImages"] == null ? [] : List<dynamic>.from(json["responsiveImages"]!.map((x) => x)),
        orderColumn: json["orderColumn"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "manipulations": manipulations == null ? [] : List<dynamic>.from(manipulations!.map((x) => x)),
        "customProperties": customProperties == null ? [] : List<dynamic>.from(customProperties!.map((x) => x)),
        "generatedConversions": generatedConversions == null ? [] : List<dynamic>.from(generatedConversions!.map((x) => x)),
        "responsiveImages": responsiveImages == null ? [] : List<dynamic>.from(responsiveImages!.map((x) => x)),
        "orderColumn": orderColumn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "originalUrl": originalUrl,
        "previewUrl": previewUrl,
    };
}

class SubjectDetails {
    final String? title;
    final String? description;
    final dynamic signedPhotoUrl;
    final List<dynamic>? media;

    SubjectDetails({
        this.title,
        this.description,
        this.signedPhotoUrl,
        this.media,
    });

    factory SubjectDetails.fromJson(Map<String, dynamic> json) => SubjectDetails(
        title: json["title"],
        description: json["description"],
        signedPhotoUrl: json["signedPhotoUrl"],
        media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "signedPhotoUrl": signedPhotoUrl,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
    };
}
