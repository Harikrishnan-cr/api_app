// To parse this JSON data, do
//
//     final performanceModelClass = performanceModelClassFromJson(jsonString);

import 'dart:convert';

PerformanceModelClass performanceModelClassFromJson(String str) =>
    PerformanceModelClass.fromJson(json.decode(str));

String performanceModelClassToJson(PerformanceModelClass data) =>
    json.encode(data.toJson());

class PerformanceModelClass {
  bool? status;
  Data? data;
  String? message;

  PerformanceModelClass({
    this.status,
    this.data,
    this.message,
  });

  factory PerformanceModelClass.fromJson(Map<String, dynamic> json) =>
      PerformanceModelClass(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<String>? months;
  List<int>? attendance;
  int? attendanceScore;
  List<int>? exam;
  int? examScore;
  List<int>? quiz;
  int? quizScore;
  List<int>? assignment;
  int? assignmentScore;
  int? overallPercentage;
  List<int>? overall;
  int? studentId;

  Data({
    this.months,
    this.attendance,
    this.attendanceScore,
    this.exam,
    this.examScore,
    this.quiz,
    this.quizScore,
    this.assignment,
    this.assignmentScore,
    this.overallPercentage,
    this.overall,
    this.studentId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        months: json["months"] == null
            ? []
            : List<String>.from(json["months"]!.map((x) => x)),
        attendance: json["attendance"] == null
            ? []
            : List<int>.from(json["attendance"]!.map((x) => x)),
        attendanceScore: json["attendanceScore"],
        exam: json["exam"] == null
            ? []
            : List<int>.from(json["exam"]!.map((x) => x)),
        examScore: json["examScore"],
        quiz: json["quiz"] == null
            ? []
            : List<int>.from(json["quiz"]!.map((x) => x)),
        quizScore: json["quizScore"],
        assignment: json["assignment"] == null
            ? []
            : List<int>.from(json["assignment"]!.map((x) => x)),
        assignmentScore: json["assignmentScore"],
        overallPercentage: json["overallPercentage"],
        overall: json["overall"] == null
            ? []
            : List<int>.from(json["overall"]!.map((x) => x)),
        studentId: json["studentId"],
      );

  Map<String, dynamic> toJson() => {
        "months":
            months == null ? [] : List<dynamic>.from(months!.map((x) => x)),
        "attendance": attendance == null
            ? []
            : List<dynamic>.from(attendance!.map((x) => x)),
        "attendanceScore": attendanceScore,
        "exam": exam == null ? [] : List<dynamic>.from(exam!.map((x) => x)),
        "examScore": examScore,
        "quiz": quiz == null ? [] : List<dynamic>.from(quiz!.map((x) => x)),
        "quizScore": quizScore,
        "assignment": assignment == null
            ? []
            : List<dynamic>.from(assignment!.map((x) => x)),
        "assignmentScore": assignmentScore,
        "overallPercentage": overallPercentage,
        "overall":
            overall == null ? [] : List<dynamic>.from(overall!.map((x) => x)),
        "studentId": studentId,
      };
}
