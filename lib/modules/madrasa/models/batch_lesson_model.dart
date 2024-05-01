import 'package:samastha/modules/courses/models/course_chapters_model.dart';

class BatchLessonJsonModel {
  bool? status;
  List<BatchLessonModel>? data;
  String? message;

  BatchLessonJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory BatchLessonJsonModel.fromJson(Map<String, dynamic> json) =>
      BatchLessonJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<BatchLessonModel>.from(
                json["data"]!.map((x) => BatchLessonModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class BatchLessonModel {
  int? id;
  String? mediaUrl;
  String? type;
  String? videoDuration;
  String? materialDetails;
  int? isFree;
  int? fkSubjectLessonId;
  String? downloadedStatus;
  String? pausedDuration;
  String? title;
  String? subTitle;
  String? image;
  String? description;
  dynamic photoUrl;
  dynamic url;
  List<PopupQuestion>? popupQuestion;

  BatchLessonModel({
    this.id,
    this.mediaUrl,
    this.type,
    this.videoDuration,
    this.materialDetails,
    this.isFree,
    this.fkSubjectLessonId,
    this.downloadedStatus,
    this.pausedDuration,
    this.title,
    this.subTitle,
    this.image,
    this.description,
    this.photoUrl,
    this.url,
    this.popupQuestion,
  });

  factory BatchLessonModel.fromJson(Map<String, dynamic> json) =>
      BatchLessonModel(
        id: json["id"],
        mediaUrl: json["mediaUrl"],
        type: json["type"],
        videoDuration: json["videoDuration"],
        materialDetails: json["materialDetails"],
        isFree: json["isFree"],
        fkSubjectLessonId: json["fkSubjectLessonId"],
        downloadedStatus: json["downloadedStatus"],
        pausedDuration: json["pausedDuration"],
        title: json["title"],
        subTitle: json["subTitle"],
        image: json["image"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        url: json["url"],
        popupQuestion: json["popupQuestion"] == null
            ? []
            : List<PopupQuestion>.from(
                json["popupQuestion"]!.map((x) => PopupQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mediaUrl": mediaUrl,
        "type": type,
        "videoDuration": videoDuration,
        "materialDetails": materialDetails,
        "isFree": isFree,
        "fkSubjectLessonId": fkSubjectLessonId,
        "downloadedStatus": downloadedStatus,
        "pausedDuration": pausedDuration,
        "title": title,
        "subTitle": subTitle,
        "image": image,
        "description": description,
        "photoUrl": photoUrl,
        "url": url,
        "popupQuestion": popupQuestion == null
            ? []
            : List<dynamic>.from(popupQuestion!.map((x) => x.toJson())),
      };
}

// class PopupQuestion {
//   int? id;
//   int? fkSubjectMaterialId;
//   String? duration;
//   List<Question>? questions;

//   PopupQuestion({
//     this.id,
//     this.fkSubjectMaterialId,
//     this.duration,
//     this.questions,
//   });

//   factory PopupQuestion.fromJson(Map<String, dynamic> json) => PopupQuestion(
//         id: json["id"],
//         fkSubjectMaterialId: json["fkSubjectMaterialId"],
//         duration: json["duration"],
//         questions: json["questions"] == null
//             ? []
//             : List<Question>.from(
//                 json["questions"]!.map((x) => Question.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "fkSubjectMaterialId": fkSubjectMaterialId,
//         "duration": duration,
//         "questions": questions == null
//             ? []
//             : List<dynamic>.from(questions!.map((x) => x.toJson())),
//       };
// }

// class Question {
//   int? id;
//   String? hint;
//   String? question;
//   List<Option>? options;

//   Question({
//     this.id,
//     this.hint,
//     this.question,
//     this.options,
//   });

//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//         id: json["id"],
//         hint: json["hint"],
//         question: json["question"],
//         options: json["options"] == null
//             ? []
//             : List<Option>.from(
//                 json["options"]!.map((x) => Option.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "hint": hint,
//         "question": question,
//         "options": options == null
//             ? []
//             : List<dynamic>.from(options!.map((x) => x.toJson())),
//       };
// }

// class Option {
//   int? id;
//   String? optionName;
//   int? isCorrect;
//   int? fkPopupQuestionId;

//   Option({
//     this.id,
//     this.optionName,
//     this.isCorrect,
//     this.fkPopupQuestionId,
//   });

//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//         id: json["id"],
//         optionName: json["optionName"],
//         isCorrect: json["isCorrect"],
//         fkPopupQuestionId: json["fkPopupQuestionId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "optionName": optionName,
//         "isCorrect": isCorrect,
//         "fkPopupQuestionId": fkPopupQuestionId,
//       };
// }
