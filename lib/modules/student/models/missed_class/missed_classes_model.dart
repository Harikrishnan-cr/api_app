class MissedClassesJsonModel {
  bool? status;
  MissedClassData? data;

  MissedClassesJsonModel({
    this.status,
    this.data,
  });

  factory MissedClassesJsonModel.fromJson(Map<String, dynamic> json) =>
      MissedClassesJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : MissedClassData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class MissedClassData {
  int? studentId;
  List<MissedSubject>? subjects;
  int? missedClassId;

  MissedClassData({
    this.studentId,
    this.subjects,
    this.missedClassId
  });

  factory MissedClassData.fromJson(Map<String, dynamic> json) =>
      MissedClassData(
        studentId: json["studentId"],
        missedClassId: json["missedClassId"],
        subjects: json["subjects"] == null
            ? []
            : List<MissedSubject>.from(
                json["subjects"]!.map((x) => MissedSubject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "missedClassId": missedClassId,
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

class MissedSubject {
  int? id;
  String? title;
  String? imageUrl;
  List<Lesson>? lessons;

  MissedSubject({
    this.id,
    this.title,
    this.imageUrl,
    this.lessons,
  });

  factory MissedSubject.fromJson(Map<String, dynamic> json) => MissedSubject(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
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
