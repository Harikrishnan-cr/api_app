// To parse this JSON data, do
//
//     final leaderBoardModel = leaderBoardModelFromJson(jsonString);

import 'dart:convert';

LeaderBoardModel leaderBoardModelFromJson(String str) =>
    LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) =>
    json.encode(data.toJson());

class LeaderBoardModel {
  bool? status;
  LeaderBoardData? data;

  LeaderBoardModel({
    this.status,
    this.data,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : LeaderBoardData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class LeaderBoardData {
  List<LeaderBoardStudnetList>? batchStudents;
  List<LeaderBoardStudnetList>? globalStudents;

  LeaderBoardData({
    this.batchStudents,
    this.globalStudents,
  });

  factory LeaderBoardData.fromJson(Map<String, dynamic> json) =>
      LeaderBoardData(
        batchStudents: json["batchStudents"] == null
            ? []
            : List<LeaderBoardStudnetList>.from(json["batchStudents"]!
                .map((x) => LeaderBoardStudnetList.fromJson(x))),
        globalStudents: json["globalStudents"] == null
            ? []
            : List<LeaderBoardStudnetList>.from(json["globalStudents"]!
                .map((x) => LeaderBoardStudnetList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batchStudents": batchStudents == null
            ? []
            : List<dynamic>.from(batchStudents!.map((x) => x.toJson())),
        "globalStudents": globalStudents == null
            ? []
            : List<dynamic>.from(globalStudents!.map((x) => x.toJson())),
      };
}

class LeaderBoardStudnetList {
  int? id;
  int? fkExamPoolId;
  int? fkStudentId;
  dynamic fkRegularStudentId;
  dynamic fkBatchStudentId;
  dynamic fkCourseId;
  String? status;
  int? mark;
  DateTime? attendedDate;
  dynamic uniqueId;
  dynamic resultStatus;
  int? createdBy;
  int? updatedBy;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  num? timeTakenMin;
  int? fkClassId;
  int? totalMark;
  StudentClass? student;

  LeaderBoardStudnetList({
    this.id,
    this.fkExamPoolId,
    this.fkStudentId,
    this.fkRegularStudentId,
    this.fkBatchStudentId,
    this.fkCourseId,
    this.status,
    this.mark,
    this.attendedDate,
    this.uniqueId,
    this.resultStatus,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.timeTakenMin,
    this.fkClassId,
    this.totalMark,
    this.student,
  });

  factory LeaderBoardStudnetList.fromJson(Map<String, dynamic> json) =>
      LeaderBoardStudnetList(
        id: json["id"],
        fkExamPoolId: json["fkExamPoolId"],
        fkStudentId: json["fkStudentId"],
        fkRegularStudentId: json["fkRegularStudentId"],
        fkBatchStudentId: json["fkBatchStudentId"],
        fkCourseId: json["fkCourseId"],
        status: json["status"],
        mark: json["mark"],
        attendedDate: json["attendedDate"] == null
            ? null
            : DateTime.parse(json["attendedDate"]),
        uniqueId: json["uniqueId"],
        resultStatus: json["resultStatus"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        timeTakenMin: json["timeTakenMin"],
        fkClassId: json["fkClassId"],
        totalMark: json["totalMark"],
        student: json["student"] == null
            ? null
            : StudentClass.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkExamPoolId": fkExamPoolId,
        "fkStudentId": fkStudentId,
        "fkRegularStudentId": fkRegularStudentId,
        "fkBatchStudentId": fkBatchStudentId,
        "fkCourseId": fkCourseId,
        "status": status,
        "mark": mark,
        "attendedDate":
            "${attendedDate!.year.toString().padLeft(4, '0')}-${attendedDate!.month.toString().padLeft(2, '0')}-${attendedDate!.day.toString().padLeft(2, '0')}",
        "uniqueId": uniqueId,
        "resultStatus": resultStatus,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "timeTakenMin": timeTakenMin,
        "fkClassId": fkClassId,
        "totalMark": totalMark,
        "student": student?.toJson(),
      };
}

class StudentClass {
  int? id;
  String? studentDisplayId;
  String? name;
  String? email;
  String? phoneNumber;
  String? dob;
  String? gender;
  String? applicationNumber;
  dynamic tcNo;
  String? tcUrl;
  dynamic photoUrl;
  dynamic certificateUrl;
  int? fkParentId;
  int? fkUserId;
  int? createdBy;
  int? updatedBy;
  String? status;
  int? isActive;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  int? fkCountryId;
  int? fkStateId;
  String? birthCertificateUrl;
  int? joinedClassId;
  dynamic address;
  int? currentBatchId;
  dynamic signedPhotoUrl;
  String? encodedId;
  String? imageUrl;
  Batch? batch;
  Country? country;
  List<Media>? media;

  StudentClass({
    this.id,
    this.studentDisplayId,
    this.name,
    this.email,
    this.phoneNumber,
    this.dob,
    this.gender,
    this.applicationNumber,
    this.tcNo,
    this.tcUrl,
    this.photoUrl,
    this.certificateUrl,
    this.fkParentId,
    this.fkUserId,
    this.createdBy,
    this.updatedBy,
    this.status,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.fkCountryId,
    this.fkStateId,
    this.birthCertificateUrl,
    this.joinedClassId,
    this.address,
    this.currentBatchId,
    this.signedPhotoUrl,
    this.encodedId,
    this.imageUrl,
    this.batch,
    this.country,
    this.media,
  });

  factory StudentClass.fromJson(Map<String, dynamic> json) => StudentClass(
        id: json["id"],
        studentDisplayId: json["studentDisplayId"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        dob: json["dob"],
        gender: json["gender"],
        applicationNumber: json["applicationNumber"],
        tcNo: json["tcNo"],
        tcUrl: json["tcUrl"],
        photoUrl: json["photoUrl"],
        certificateUrl: json["certificateUrl"],
        fkParentId: json["fkParentId"],
        fkUserId: json["fkUserId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        status: json["status"],
        isActive: json["isActive"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        fkCountryId: json["fkCountryId"],
        fkStateId: json["fkStateId"],
        birthCertificateUrl: json["birthCertificateUrl"],
        joinedClassId: json["joinedClassId"],
        address: json["address"],
        currentBatchId: json["currentBatchId"],
        signedPhotoUrl: json["signedPhotoUrl"],
        encodedId: json["encodedId"],
        imageUrl: json["imageUrl"],
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentDisplayId": studentDisplayId,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "dob": dob,
        "gender": gender,
        "applicationNumber": applicationNumber,
        "tcNo": tcNo,
        "tcUrl": tcUrl,
        "photoUrl": photoUrl,
        "certificateUrl": certificateUrl,
        "fkParentId": fkParentId,
        "fkUserId": fkUserId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "status": status,
        "isActive": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "fkCountryId": fkCountryId,
        "fkStateId": fkStateId,
        "birthCertificateUrl": birthCertificateUrl,
        "joinedClassId": joinedClassId,
        "address": address,
        "currentBatchId": currentBatchId,
        "signedPhotoUrl": signedPhotoUrl,
        "encodedId": encodedId,
        "imageUrl": imageUrl,
        "batch": batch?.toJson(),
        "country": country?.toJson(),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Batch {
  int? id;
  String? name;
  int? fkClassId;
  AcademicClass? academicClass;

  Batch({
    this.id,
    this.name,
    this.fkClassId,
    this.academicClass,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
        fkClassId: json["fkClassId"],
        academicClass: json["academicClass"] == null
            ? null
            : AcademicClass.fromJson(json["academicClass"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fkClassId": fkClassId,
        "academicClass": academicClass?.toJson(),
      };
}

class AcademicClass {
  int? id;
  String? classDisplayId;
  String? name;
  dynamic photoUrl;
  int? createdBy;
  int? updatedBy;
  String? status;
  int? isActive;
  int? sortOrder;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  dynamic ageMin;
  dynamic ageMax;
  int? isFirstStandard;
  dynamic onetooneFee;
  String? classType;
  dynamic zoomLink;

  AcademicClass({
    this.id,
    this.classDisplayId,
    this.name,
    this.photoUrl,
    this.createdBy,
    this.updatedBy,
    this.status,
    this.isActive,
    this.sortOrder,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.ageMin,
    this.ageMax,
    this.isFirstStandard,
    this.onetooneFee,
    this.classType,
    this.zoomLink,
  });

  factory AcademicClass.fromJson(Map<String, dynamic> json) => AcademicClass(
        id: json["id"],
        classDisplayId: json["classDisplayId"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        status: json["status"],
        isActive: json["isActive"],
        sortOrder: json["sortOrder"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        ageMin: json["ageMin"],
        ageMax: json["ageMax"],
        isFirstStandard: json["isFirstStandard"],
        onetooneFee: json["onetooneFee"],
        classType: json["classType"],
        zoomLink: json["zoomLink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "classDisplayId": classDisplayId,
        "name": name,
        "photoUrl": photoUrl,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "status": status,
        "isActive": isActive,
        "sortOrder": sortOrder,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "ageMin": ageMin,
        "ageMax": ageMax,
        "isFirstStandard": isFirstStandard,
        "onetooneFee": onetooneFee,
        "classType": classType,
        "zoomLink": zoomLink,
      };
}

class Country {
  int? id;
  String? title;
  String? code;
  int? createdBy;
  int? updatedBy;
  int? isActive;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Country({
    this.id,
    this.title,
    this.code,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        title: json["title"],
        code: json["code"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
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
