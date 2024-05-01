// To parse this JSON data, do
//
//     final tImeSlotModel = tImeSlotModelFromJson(jsonString);

import 'dart:convert';

TimeSlotModel tImeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String tImeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  final int? id;
  final String? startTime;
  final String? endTime;
  final TimeSlot? timeSlot;
  final TimeSlot? timeSlotEnd;

  TimeSlotModel({
    this.id,
    this.startTime,
    this.endTime,
    this.timeSlot,
    this.timeSlotEnd,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        timeSlot: json["timeSlot"] == null
            ? null
            : TimeSlot.fromJson(json["timeSlot"]),
        timeSlotEnd: json["timeSlotEnd"] == null
            ? null
            : TimeSlot.fromJson(json["timeSlotEnd"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "timeSlot": timeSlot?.toJson(),
        "timeSlotEnd": timeSlotEnd?.toJson(),
      };
}

class TimeSlot {
  final int? id;
  final String? title;

  TimeSlot({
    this.id,
    this.title,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
