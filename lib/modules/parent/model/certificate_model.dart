// To parse this JSON data, do
//
//     final certificateModel = certificateModelFromJson(jsonString);

import 'dart:convert';

CertificateModel certificateModelFromJson(String str) =>
    CertificateModel.fromJson(json.decode(str));

String certificateModelToJson(CertificateModel data) =>
    json.encode(data.toJson());

class CertificateModel {
  bool? status;
  List<CertificateModelList>? certificateModelList;
  String? message;

  CertificateModel({
    this.status,
    this.certificateModelList,
    this.message,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) =>
      CertificateModel(
        status: json["status"],
        certificateModelList: json["data"] == null
            ? []
            : List<CertificateModelList>.from(
                json["data"]!.map((x) => CertificateModelList.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": certificateModelList == null
            ? []
            : List<dynamic>.from(certificateModelList!.map((x) => x.toJson())),
        "message": message,
      };
}

class CertificateModelList {
  int? id;
  int? fkUserId;
  int? createdBy;
  int? updatedBy;
  int? isActive;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  int? fkCertificateId;
  int? isApproved;
  String? downloadLink;
  String? encodedId;
  Certificate? certificate;

  CertificateModelList({
    this.id,
    this.fkUserId,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.fkCertificateId,
    this.isApproved,
    this.downloadLink,
    this.encodedId,
    this.certificate,
  });

  factory CertificateModelList.fromJson(Map<String, dynamic> json) {
    final baseUrl = json["downloadLink"].toString().split('?').first;

    final cirtificateId = json["downloadLink"].toString().split('id=').last;

    return CertificateModelList(
      id: json["id"],
      fkUserId: json["fkUserId"],
      createdBy: json["createdBy"],
      updatedBy: json["updatedBy"],
      isActive: json["isActive"],
      deletedAt: json["deletedAt"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      fkCertificateId: json["fkCertificateId"],
      isApproved: json["isApproved"],
      downloadLink: '$baseUrl/$cirtificateId',
      encodedId: json["encodedId"],
      certificate: json["certificate"] == null
          ? null
          : Certificate.fromJson(json["certificate"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkUserId": fkUserId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "fkCertificateId": fkCertificateId,
        "isApproved": isApproved,
        "downloadLink": downloadLink,
        "encodedId": encodedId,
        "certificate": certificate?.toJson(),
      };
}

class Certificate {
  int? id;
  String? type;
  dynamic name;
  String? title;
  dynamic subTitle;
  String? details;
  dynamic fkClassId;
  dynamic fkBatchId;
  int? fkCourseId;
  int? createdBy;
  int? updatedBy;
  int? isActive;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  Course? course;
  List<Signature>? signature;
  dynamic academicClass;

  Certificate({
    this.id,
    this.type,
    this.name,
    this.title,
    this.subTitle,
    this.details,
    this.fkClassId,
    this.fkBatchId,
    this.fkCourseId,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.course,
    this.signature,
    this.academicClass,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        title: json["title"],
        subTitle: json["subTitle"],
        details: json["details"],
        fkClassId: json["fkClassId"],
        fkBatchId: json["fkBatchId"],
        fkCourseId: json["fkCourseId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        signature: json["signature"] == null
            ? []
            : List<Signature>.from(
                json["signature"]!.map((x) => Signature.fromJson(x))),
        academicClass: json["academicClass"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "title": title,
        "subTitle": subTitle,
        "details": details,
        "fkClassId": fkClassId,
        "fkBatchId": fkBatchId,
        "fkCourseId": fkCourseId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "course": course?.toJson(),
        "signature": signature == null
            ? []
            : List<dynamic>.from(signature!.map((x) => x.toJson())),
        "academicClass": academicClass,
      };
}

class Course {
  int? id;
  String? title;
  String? courseDisplayId;
  String? subTitle;
  dynamic description;
  int? price;
  dynamic whatWillLearn;
  String? courseDuration;
  String? photoUrl;
  int? createdBy;
  int? updatedBy;
  int? isActive;
  int? sortOrder;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  int? isPopular;
  String? durationType;
  int? fromTutor;
  String? encodedId;
  String? signedPhotoUrl;
  List<Media>? media;

  Course({
    this.id,
    this.title,
    this.courseDisplayId,
    this.subTitle,
    this.description,
    this.price,
    this.whatWillLearn,
    this.courseDuration,
    this.photoUrl,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.sortOrder,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isPopular,
    this.durationType,
    this.fromTutor,
    this.encodedId,
    this.signedPhotoUrl,
    this.media,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        courseDisplayId: json["courseDisplayId"],
        subTitle: json["subTitle"],
        description: json["description"],
        price: json["price"],
        whatWillLearn: json["whatWillLearn"],
        courseDuration: json["courseDuration"],
        photoUrl: json["photoUrl"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        sortOrder: json["sortOrder"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        isPopular: json["isPopular"],
        durationType: json["durationType"],
        fromTutor: json["fromTutor"],
        encodedId: json["encodedId"],
        signedPhotoUrl: json["signedPhotoUrl"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "courseDisplayId": courseDisplayId,
        "subTitle": subTitle,
        "description": description,
        "price": price,
        "whatWillLearn": whatWillLearn,
        "courseDuration": courseDuration,
        "photoUrl": photoUrl,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "sortOrder": sortOrder,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isPopular": isPopular,
        "durationType": durationType,
        "fromTutor": fromTutor,
        "encodedId": encodedId,
        "signedPhotoUrl": signedPhotoUrl,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

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
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "originalUrl": originalUrl,
        "previewUrl": previewUrl,
      };
}

class Signature {
  int? id;
  int? fkCertificateId;
  String? signature;
  String? name;
  String? designation;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? signedSignature;
  List<Media>? media;

  Signature({
    this.id,
    this.fkCertificateId,
    this.signature,
    this.name,
    this.designation,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.signedSignature,
    this.media,
  });

  factory Signature.fromJson(Map<String, dynamic> json) => Signature(
        id: json["id"],
        fkCertificateId: json["fkCertificateId"],
        signature: json["signature"],
        name: json["name"],
        designation: json["designation"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        signedSignature: json["signedSignature"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkCertificateId": fkCertificateId,
        "signature": signature,
        "name": name,
        "designation": designation,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "signedSignature": signedSignature,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}
