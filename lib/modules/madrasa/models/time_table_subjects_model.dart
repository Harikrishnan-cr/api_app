class TimeTableSubjectsResponseModel {
  bool? status;
  List<TimeTableSubjectsModel>? data;

  TimeTableSubjectsResponseModel({
    this.status,
    this.data,
  });

  factory TimeTableSubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      TimeTableSubjectsResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<TimeTableSubjectsModel>.from(
                json["data"]!.map((x) => TimeTableSubjectsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TimeTableSubjectsModel {
  int? id;
  DateTime? lessonDate;
  List<TimeTableSubject>? subjects;

  TimeTableSubjectsModel({
    this.id,
    this.lessonDate,
    this.subjects,
  });

  factory TimeTableSubjectsModel.fromJson(Map<String, dynamic> json) =>
      TimeTableSubjectsModel(
        id: json["id"],
        lessonDate: json["lessonDate"] == null
            ? null
            : DateTime.parse(json["lessonDate"]),
        subjects: json["subjects"] == null
            ? []
            : List<TimeTableSubject>.from(
                json["subjects"]!.map((x) => TimeTableSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lessonDate":
            "${lessonDate!.year.toString().padLeft(4, '0')}-${lessonDate!.month.toString().padLeft(2, '0')}-${lessonDate!.day.toString().padLeft(2, '0')}",
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

class TimeTableSubject {
  int? id;
  String? title;
  String? signedPhotoUrl;
  List<Lesson>? lessons;

  TimeTableSubject({
    this.id,
    this.title,
    this.signedPhotoUrl,
    this.lessons,
  });

  factory TimeTableSubject.fromJson(Map<String, dynamic> json) =>
      TimeTableSubject(
        id: json["id"],
        title: json["title"],
        signedPhotoUrl: json["signedPhotoUrl"],
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "signedPhotoUrl": signedPhotoUrl,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  String? lessonDisplayId;
  String? title;
  String? subTitle;
  int? fkSubjectId;
  int? isActive;

  Lesson({
    this.lessonDisplayId,
    this.title,
    this.subTitle,
    this.fkSubjectId,
    this.isActive,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        lessonDisplayId: json["lessonDisplayId"],
        title: json["title"],
        subTitle: json["subTitle"],
        fkSubjectId: json["fkSubjectId"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "lessonDisplayId": lessonDisplayId,
        "title": title,
        "subTitle": subTitle,
        "fkSubjectId": fkSubjectId,
        "isActive": isActive,
      };
}
