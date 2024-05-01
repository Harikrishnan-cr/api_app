import 'dart:developer';

class CourseChaptersJsonModel {
  bool? status;
  CourseChaptersData? data;
  String? message;

  CourseChaptersJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory CourseChaptersJsonModel.fromJson(Map<String, dynamic> json) =>
      CourseChaptersJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : CourseChaptersData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class CourseChaptersData {
  List<Lesson>? subjectLessons;
  List<Lesson>? demoLessons;

  CourseChaptersData({
    this.subjectLessons,
    this.demoLessons,
  });

  factory CourseChaptersData.fromJson(Map<String, dynamic> json) =>
      CourseChaptersData(
        subjectLessons: json["subjectLessons"] == null
            ? []
            : List<Lesson>.from(
                json["subjectLessons"]!.map((x) => Lesson.fromJson(x))),
        demoLessons: json["demoLessons"] == null
            ? []
            : List<Lesson>.from(
                json["demoLessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjectLessons": subjectLessons == null
            ? []
            : List<dynamic>.from(subjectLessons!.map((x) => x.toJson())),
        "demoLessons": demoLessons == null
            ? []
            : List<dynamic>.from(demoLessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  int? id;
  String? mediaUrl;
  String? type;
  String? courseDuration;
  String? materialDetails;
  int? isDemo;
  String? downloadedStatus;
  String? url;
  List<PopupQuestion>? popupQuestion;

  String? title;
  String? subTitle;
  String? description;
  String? thumbnailUrl;
  String? image;
  bool? isDownloadStarted;
  // String? videoDuration;

  Lesson({
    this.id,
    this.mediaUrl,
    this.isDownloadStarted = false,
    this.type,
    this.courseDuration,
    this.materialDetails,
    this.isDemo,
    this.downloadedStatus,
    this.url,
    this.popupQuestion,
    this.description,
    this.thumbnailUrl,
    this.title,
    this.subTitle,
    this.image,
    // this.videoDuration
  });

  @override
  String toString() {
    return '''Lesson{
       
        'thumb: $thumbnailUrl,}';
   
   }''';
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    log('thumbnail ${json["photoUrl"] ?? 'https://i.ytimg.com/vi/BolYvL35UaA/hqdefault.jpg'}');
    return Lesson(
      id: json["id"],
      mediaUrl: json["mediaUrl"],
      type: json["type"],
      courseDuration: json["courseDuration"],
      materialDetails: json["materialDetails"],
      isDemo: json["isDemo"],
      downloadedStatus: json["downloadedStatus"],
      url: json["url"],
      title: json["title"],
      subTitle: json["subTitle"],
      image: json["image"],
      description: json["description"],
      thumbnailUrl:
          json['photoUrl'].toString().isEmpty || json['photoUrl'] == null
              ? 'https://i.ytimg.com/vi/BolYvL35UaA/hqdefault.jpg'
              : json['photoUrl'],
      popupQuestion: json["popupQuestion"] == null
          ? []
          : List<PopupQuestion>.from(
              json["popupQuestion"]!.map((x) => PopupQuestion.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "mediaUrl": mediaUrl,
        "type": type,
        "courseDuration": courseDuration,
        "materialDetails": materialDetails,
        "isDemo": isDemo,
        "downloadedStatus": downloadedStatus,
        "url": url,
        "popupQuestion": popupQuestion == null
            ? []
            : List<dynamic>.from(popupQuestion!.map((x) => x.toJson())),
      };
}

class PopupQuestion {
  int? id;
  int? fkCourseMaterialId;
  String? duration;
  int? fkPopupQuestionId;
  Question? question;

  PopupQuestion({
    this.id,
    this.fkCourseMaterialId,
    this.duration,
    this.fkPopupQuestionId,
    this.question,
  });

  factory PopupQuestion.fromJson(Map<String, dynamic> json) => PopupQuestion(
        id: json["id"],
        fkCourseMaterialId: json["fkCourseMaterialId"],
        duration: json["duration"],
        fkPopupQuestionId: json["fkPopupQuestionId"],
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkCourseMaterialId": fkCourseMaterialId,
        "duration": duration,
        "fkPopupQuestionId": fkPopupQuestionId,
        "question": question?.toJson(),
      };
}

class Question {
  int? id;
  String? hint;
  String? question;
  List<Option>? options;

  Question({
    this.id,
    this.hint,
    this.question,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        hint: json["hint"],
        question: json["question"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hint": hint,
        "question": question,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  int? id;
  String? optionName;
  dynamic photoUrl;
  int? fkPopupQuestionId;
  int? isCorrect;
  int? createdBy;
  int? updatedBy;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Option({
    this.id,
    this.optionName,
    this.photoUrl,
    this.fkPopupQuestionId,
    this.isCorrect,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        optionName: json["optionName"],
        photoUrl: json["photoUrl"],
        fkPopupQuestionId: json["fkPopupQuestionId"],
        isCorrect: json["isCorrect"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "optionName": optionName,
        "photoUrl": photoUrl,
        "fkPopupQuestionId": fkPopupQuestionId,
        "isCorrect": isCorrect,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
