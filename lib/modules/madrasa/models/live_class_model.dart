// To parse this JSON data, do
//
//     final liveClassModel = liveClassModelFromJson(jsonString);

import 'dart:convert';

LiveClassModel liveClassModelFromJson(String str) =>
    LiveClassModel.fromJson(json.decode(str));

String liveClassModelToJson(LiveClassModel data) => json.encode(data.toJson());

class LiveClassModel {
  bool? status;
  LiveLCassData? data;
  String? message;

  LiveClassModel({
    this.status,
    this.data,
    this.message,
  });

  factory LiveClassModel.fromJson(Map<String, dynamic> json) => LiveClassModel(
        status: json["status"],
        data:
            json["data"] == null ? null : LiveLCassData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class LiveLCassData {
  List<LiveClassList>? data;
  int? studentId;

  LiveLCassData({
    this.data,
    this.studentId,
  });

  factory LiveLCassData.fromJson(Map<String, dynamic> json) => LiveLCassData(
        data: json["data"] == null
            ? []
            : List<LiveClassList>.from(
                json["data"]!.map((x) => LiveClassList.fromJson(x))),
        studentId: json["studentId"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "studentId": studentId,
      };
}

class LiveClassList {
  int? fkClassId;
  String? zoomLink;
  DateTime? zoomDate;
  String? zoomTime;
  int? isActive;
  int? id;
  String? zoomID;
  String? createdAt;
  String? updatedAt;

  LiveClassList({
    this.zoomID,
    this.fkClassId,
    this.zoomLink,
    this.zoomDate,
    this.zoomTime,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory LiveClassList.fromJson(Map<String, dynamic> json) => LiveClassList(
        fkClassId: json["fkClassId"],
        zoomLink: json["zoomLink"],
        zoomDate:
            json["zoomDate"] == null ? null : DateTime.parse(json["zoomDate"]),
        zoomTime: json["zoomTime"],
        isActive: json["isActive"],
        id: json["id"],
        zoomID: json["zoomId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "fkClassId": fkClassId,
        "zoomLink": zoomLink,
        "zoomDate":
            "${zoomDate!.year.toString().padLeft(4, '0')}-${zoomDate!.month.toString().padLeft(2, '0')}-${zoomDate!.day.toString().padLeft(2, '0')}",
        "zoomTime": zoomTime,
        "isActive": isActive,
        "id": id,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
