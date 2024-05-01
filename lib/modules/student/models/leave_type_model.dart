// To parse this JSON data, do
//
//     final leaveTypeModel = leaveTypeModelFromJson(jsonString);

import 'dart:convert';

LeaveTypeModel leaveTypeModelFromJson(String str) =>
    LeaveTypeModel.fromJson(json.decode(str));

String leaveTypeModelToJson(LeaveTypeModel data) => json.encode(data.toJson());

class LeaveTypeModel {
  final int? id;
  final String? leaveName;
  final String? leaveDisplayName;

  LeaveTypeModel({
    this.id,
    this.leaveName,
    this.leaveDisplayName,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => LeaveTypeModel(
        id: json["id"],
        leaveName: json["leaveName"],
        leaveDisplayName: json["leaveDisplayName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leaveName": leaveName,
        "leaveDisplayName": leaveDisplayName,
      };

  @override
  String toString() {
    return leaveName.toString();
  }
}
