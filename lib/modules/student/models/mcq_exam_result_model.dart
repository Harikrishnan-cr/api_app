// To parse this JSON data, do
//
//     final examResultModel = examResultModelFromJson(jsonString);

import 'dart:convert';

ExamResultModel examResultModelFromJson(String str) =>
    ExamResultModel.fromJson(json.decode(str));

String examResultModelToJson(ExamResultModel data) =>
    json.encode(data.toJson());

class ExamResultModel {
  final int? studentId;
  final String? studentName;
  final num? mark;
  final num? totalMark, correctAnswers, wrongAnswers, passMark;
  final String? status, message;

  ExamResultModel({
    this.studentId,
    this.correctAnswers,
    this.studentName,
    this.wrongAnswers,
    this.passMark,
    this.mark,
    this.totalMark,
    this.message,
    this.status,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      ExamResultModel(
        studentId: json["studentId"],
        studentName: json["studentName"],
        mark: json["mark"],
        totalMark: json["totalMark"],
        status: json["status"],
        correctAnswers: json["correctAnswers"],
        wrongAnswers: json["wrongAnswers"],
        passMark: json["passMark"],
        message: json["message"],
      );

  get shareText => "Hi mark obtained by student is $mark out of $totalMark";

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "studentName": studentName,
        "mark": mark,
        "totalMark": totalMark,
        "status": status,
      };
}
