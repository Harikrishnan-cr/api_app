// To parse this JSON data, do
//
//     final rewardModel = rewardModelFromJson(jsonString);

import 'dart:convert';

RewardModel rewardModelFromJson(String str) =>
    RewardModel.fromJson(json.decode(str));

String rewardModelToJson(RewardModel data) => json.encode(data.toJson());

class RewardModel {
  bool? status;
  RewardModelData? data;
  String? message;

  RewardModel({
    this.status,
    this.data,
    this.message,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : RewardModelData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class RewardModelData {
  DataData? data;
  int? studentId;

  RewardModelData({
    this.data,
    this.studentId,
  });

  factory RewardModelData.fromJson(Map<String, dynamic> json) =>
      RewardModelData(
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        studentId: json["studentId"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "studentId": studentId,
      };
}

class DataData {
  num? earnedPoints;
  num? spentPoints;
  num? remainingPoints;
  List<RewardHistory>? rewardHistory;

  DataData({
    this.earnedPoints,
    this.spentPoints,
    this.remainingPoints,
    this.rewardHistory,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        earnedPoints: json["earnedPoints"],
        spentPoints: json["spentPoints"],
        remainingPoints: json["remainingPoints"],
        rewardHistory: json["rewardHistory"] == null
            ? []
            : List<RewardHistory>.from(
                json["rewardHistory"]!.map((x) => RewardHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "earnedPoints": earnedPoints,
        "spentPoints": spentPoints,
        "remainingPoints": remainingPoints,
        "rewardHistory": rewardHistory == null
            ? []
            : List<dynamic>.from(rewardHistory!.map((x) => x.toJson())),
      };
}

class RewardHistory {
  String? pointType;
  num? points;

  RewardHistory({
    this.pointType,
    this.points,
  });

  factory RewardHistory.fromJson(Map<String, dynamic> json) => RewardHistory(
        pointType: json["pointType"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "pointType": pointType,
        "points": points,
      };
}
