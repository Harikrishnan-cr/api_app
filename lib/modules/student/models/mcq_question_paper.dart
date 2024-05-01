// To parse this JSON data, do
//
//     final mcqQuestionPaperModel = mcqQuestionPaperModelFromJson(jsonString);

import 'dart:convert';

McqQuestionPaperModel mcqQuestionPaperModelFromJson(String str) =>
    McqQuestionPaperModel.fromJson(json.decode(str));

String mcqQuestionPaperModelToJson(McqQuestionPaperModel data) =>
    json.encode(data.toJson());

class McqQuestionPaperModel {
  final int? countOfQuestions;
  final List<ExamQuestion>? examQuestions;
  final ExamPool? examPool;
  late int studentId;
  late int examId;

  String status = 'completed';

  int timeTaken = 0;

  McqQuestionPaperModel({
    this.countOfQuestions,
    this.examQuestions,
    this.examPool,
  });

  factory McqQuestionPaperModel.fromJson(Map<String, dynamic> json) =>
      McqQuestionPaperModel(
        countOfQuestions: json["countOfQuestions"],
        examQuestions: json["examQuestions"] == null
            ? []
            : List<ExamQuestion>.from(
                json["examQuestions"]!.map((x) => ExamQuestion.fromJson(x))),
        examPool: json["examPool"] == null
            ? null
            : ExamPool.fromJson(json["examPool"]),
      );

  Map<String, dynamic> toJson() => {
        "questions": examQuestions == null
            ? []
            : List<dynamic>.from(examQuestions!.map((x) => x.toJson())),
        'exam_id': examId,
        'student_id': studentId,
        'time_taken': timeTaken,
        'status': status
      };
}

class ExamPool {
  final int? id;
  final String? examDisplayId;
  final String? examMode;
  final int? passMark;
  final int? durationInMin;
  final int? fkClassId;
  final int? isActive;
  final int? fkExamId;
  final String? encodedId;

  ExamPool({
    this.id,
    this.examDisplayId,
    this.examMode,
    this.passMark,
    this.durationInMin,
    this.fkClassId,
    this.isActive,
    this.fkExamId,
    this.encodedId,
  });

  factory ExamPool.fromJson(Map<String, dynamic> json) => ExamPool(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        examMode: json["examMode"],
        passMark: json["passMark"],
        durationInMin: json["durationInMin"],
        fkClassId: json["fkClassId"],
        isActive: json["isActive"],
        fkExamId: json["fkExamId"],
        encodedId: json["encodedId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "examMode": examMode,
        "passMark": passMark,
        "durationInMin": durationInMin,
        "fkClassId": fkClassId,
        "isActive": isActive,
        "fkExamId": fkExamId,
        "encodedId": encodedId,
      };
}

class ExamQuestion {
  final String? question;
  final int? id;
  final int? marks;
  final List<dynamic>? images;
  final int? isActive;
  final int? noOfOptions;
  final String? examType;
  final String? answerType;
  final String? optionType;
  final String? examQuestionDisplayId;
  final List<Option>? options;
  final List<dynamic>? media;
  Option? selectedAnswer;
  String? subjectiveAnswer;
  bool isViewSolution = false;

  ExamQuestion({
    this.question,
    this.id,
    this.marks,
    this.images,
    this.isActive,
    this.noOfOptions,
    this.examType,
    this.answerType,
    this.optionType,
    this.examQuestionDisplayId,
    this.options,
    this.media,
  });

  factory ExamQuestion.fromJson(Map<String, dynamic> json) => ExamQuestion(
        question: json["question"],
        id: json["id"],
        marks: json["marks"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        isActive: json["isActive"],
        noOfOptions: json["noOfOptions"],
        examType: json["examType"],
        answerType: json["answerType"],
        optionType: json["optionType"],
        examQuestionDisplayId: json["examQuestionDisplayId"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {"questionId": id, "optionId": selectedAnswer?.id};
}

class Option {
  final int? id;
  final String? optionName;
  final String? optionDescription;
  final dynamic optionImages;
  final int? fkExamQuestionId;
  final int? isCorrect;
  final int? createdBy;
  final int? updatedBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Option({
    this.id,
    this.optionName,
    this.optionDescription,
    this.optionImages,
    this.fkExamQuestionId,
    this.isCorrect,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        optionName: json["optionName"],
        optionDescription: json["optionDescription"],
        optionImages: json["optionImages"],
        fkExamQuestionId: json["fkExamQuestionId"],
        isCorrect: json["isCorrect"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "optionName": optionName,
        "optionDescription": optionDescription,
        "optionImages": optionImages,
        "fkExamQuestionId": fkExamQuestionId,
        "isCorrect": isCorrect,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
