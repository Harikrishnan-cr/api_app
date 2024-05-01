class AcademicCalenderJsonModel {
  bool? status;
  AcademicCalenderModel? data;

  AcademicCalenderJsonModel({
    this.status,
    this.data,
  });

  factory AcademicCalenderJsonModel.fromJson(Map<String, dynamic> json) =>
      AcademicCalenderJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : AcademicCalenderModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class AcademicCalenderModel {
  int? studentId;
  List<Day>? days;

  AcademicCalenderModel({
    this.studentId,
    this.days,
  });

  factory AcademicCalenderModel.fromJson(Map<String, dynamic> json) =>
      AcademicCalenderModel(
        studentId: json["studentId"],
        days: json["days"] == null
            ? []
            : List<Day>.from(json["days"]!.map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "days": days == null
            ? []
            : List<dynamic>.from(days!.map((x) => x.toJson())),
      };
}

class Day {
  int? id;
  DateTime? lessonDate;
  int? fkBatchId;
  Time? startTime;
  Time? endTime;
  List<BatchLesson>? batchLessons;

  Day({
    this.id,
    this.lessonDate,
    this.fkBatchId,
    this.startTime,
    this.endTime,
    this.batchLessons,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        id: json["id"],
        lessonDate: json["lessonDate"] == null
            ? null
            : DateTime.parse(json["lessonDate"]),
        fkBatchId: json["fkBatchId"],
        startTime:
            json["startTime"] == null ? null : Time.fromJson(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : Time.fromJson(json["endTime"]),
        batchLessons: json["batchLessons"] == null
            ? []
            : List<BatchLesson>.from(
                json["batchLessons"]!.map((x) => BatchLesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lessonDate":
            "${lessonDate!.year.toString().padLeft(4, '0')}-${lessonDate!.month.toString().padLeft(2, '0')}-${lessonDate!.day.toString().padLeft(2, '0')}",
        "fkBatchId": fkBatchId,
        "startTime": startTime?.toJson(),
        "endTime": endTime?.toJson(),
        "batchLessons": batchLessons == null
            ? []
            : List<dynamic>.from(batchLessons!.map((x) => x.toJson())),
      };
}

class BatchLesson {
  int? id;
  int? fkBatchTopicsId;
  int? fkSubjectLessonsId;
  Lesson? lesson;

  BatchLesson({
    this.id,
    this.fkBatchTopicsId,
    this.fkSubjectLessonsId,
    this.lesson,
  });

  factory BatchLesson.fromJson(Map<String, dynamic> json) => BatchLesson(
        id: json["id"],
        fkBatchTopicsId: json["fkBatchTopicsId"],
        fkSubjectLessonsId: json["fkSubjectLessonsId"],
        lesson: json["lesson"] == null ? null : Lesson.fromJson(json["lesson"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkBatchTopicsId": fkBatchTopicsId,
        "fkSubjectLessonsId": fkSubjectLessonsId,
        "lesson": lesson?.toJson(),
      };
}

class Lesson {
  int? id;
  int? fkSubjectId;
  String? title;
  String? subTitle;
  Subject? subject;
  List<Topic>? topics;

  Lesson({
    this.id,
    this.fkSubjectId,
    this.title,
    this.subTitle,
    this.subject,
    this.topics,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        fkSubjectId: json["fkSubjectId"],
        title: json["title"],
        subTitle: json["subTitle"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        topics: json["topics"] == null
            ? []
            : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkSubjectId": fkSubjectId,
        "title": title,
        "subTitle": subTitle,
        "subject": subject?.toJson(),
        "topics": topics == null
            ? []
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
      };
}

class Topic {
  int? id;
  int? fkSubjectLessonId;
  String? title;

  Topic({
    this.id,
    this.fkSubjectLessonId,
    this.title,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        fkSubjectLessonId: json["fkSubjectLessonId"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkSubjectLessonId": fkSubjectLessonId,
        "title": title,
      };
}

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.uuid,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.conversionsDisk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.generatedConversions,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.originalUrl,
    this.previewUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        modelType: json["modelType"],
        modelId: json["modelId"],
        uuid: json["uuid"],
        collectionName: json["collectionName"],
        name: json["name"],
        fileName: json["fileName"],
        mimeType: json["mimeType"],
        disk: json["disk"],
        conversionsDisk: json["conversionsDisk"],
        size: json["size"],
        manipulations: json["manipulations"] == null
            ? []
            : List<dynamic>.from(json["manipulations"]!.map((x) => x)),
        customProperties: json["customProperties"] == null
            ? []
            : List<dynamic>.from(json["customProperties"]!.map((x) => x)),
        generatedConversions: json["generatedConversions"] == null
            ? []
            : List<dynamic>.from(json["generatedConversions"]!.map((x) => x)),
        responsiveImages: json["responsiveImages"] == null
            ? []
            : List<dynamic>.from(json["responsiveImages"]!.map((x) => x)),
        orderColumn: json["orderColumn"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        originalUrl: json["originalUrl"],
        previewUrl: json["previewUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "modelType": modelType,
        "modelId": modelId,
        "uuid": uuid,
        "collectionName": collectionName,
        "name": name,
        "fileName": fileName,
        "mimeType": mimeType,
        "disk": disk,
        "conversionsDisk": conversionsDisk,
        "size": size,
        "manipulations": manipulations == null
            ? []
            : List<dynamic>.from(manipulations!.map((x) => x)),
        "customProperties": customProperties == null
            ? []
            : List<dynamic>.from(customProperties!.map((x) => x)),
        "generatedConversions": generatedConversions == null
            ? []
            : List<dynamic>.from(generatedConversions!.map((x) => x)),
        "responsiveImages": responsiveImages == null
            ? []
            : List<dynamic>.from(responsiveImages!.map((x) => x)),
        "orderColumn": orderColumn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "originalUrl": originalUrl,
        "previewUrl": previewUrl,
      };
}

class Subject {
  int? id;
  String? subjectDisplayId;
  String? title;
  String? description;
  String? photoUrl;
  int? fkClassId;
  int? createdBy;
  int? updatedBy;
  int? isActive;
  int? sortOrder;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic signedPhotoUrl;
  List<Media>? media;

  Subject({
    this.id,
    this.subjectDisplayId,
    this.title,
    this.description,
    this.photoUrl,
    this.fkClassId,
    this.createdBy,
    this.updatedBy,
    this.isActive,
    this.sortOrder,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.signedPhotoUrl,
    this.media,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        subjectDisplayId: json["subjectDisplayId"],
        title: json["title"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        fkClassId: json["fkClassId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        sortOrder: json["sortOrder"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        signedPhotoUrl: json["signedPhotoUrl"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectDisplayId": subjectDisplayId,
        "title": title,
        "description": description,
        "photoUrl": photoUrl,
        "fkClassId": fkClassId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "isActive": isActive,
        "sortOrder": sortOrder,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "signedPhotoUrl": signedPhotoUrl,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Time {
  int? id;
  String? title;

  Time({
    this.id,
    this.title,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}


// class AcademicCalenderJsonModel {
//   bool? status;
//   List<AcademicCalenderModel>? data;

//   AcademicCalenderJsonModel({
//     this.status,
//     this.data,
//   });

//   factory AcademicCalenderJsonModel.fromJson(Map<String, dynamic> json) =>
//       AcademicCalenderJsonModel(
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<AcademicCalenderModel>.from(
//                 json["data"]!.map((x) => AcademicCalenderModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class AcademicCalenderModel {
//   int? id;
//   String? title;
//   String? signedPhotoUrl;
//   List<Lesson>? lessons;

//   AcademicCalenderModel({
//     this.id,
//     this.title,
//     this.signedPhotoUrl,
//     this.lessons,
//   });

//   factory AcademicCalenderModel.fromJson(Map<String, dynamic> json) =>
//       AcademicCalenderModel(
//         id: json["id"],
//         title: json["title"],
//         signedPhotoUrl: json["signedPhotoUrl"],
//         lessons: json["lessons"] == null
//             ? []
//             : List<Lesson>.from(
//                 json["lessons"]!.map((x) => Lesson.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "signedPhotoUrl": signedPhotoUrl,
//         "lessons": lessons == null
//             ? []
//             : List<dynamic>.from(lessons!.map((x) => x.toJson())),
//       };
// }

// class Lesson {
//   String? lessonDisplayId;
//   String? title;
//   String? subTitle;
//   int? fkSubjectId;
//   int? isActive;

//   Lesson({
//     this.lessonDisplayId,
//     this.title,
//     this.subTitle,
//     this.fkSubjectId,
//     this.isActive,
//   });

//   factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
//         lessonDisplayId: json["lessonDisplayId"],
//         title: json["title"],
//         subTitle: json["subTitle"],
        
//         fkSubjectId: json["fkSubjectId"],
//         isActive: json["isActive"],
//       );

//   Map<String, dynamic> toJson() => {
//         "lessonDisplayId": lessonDisplayId,
//         "title": title,
//         "subTitle": subTitle,
//         "fkSubjectId": fkSubjectId,
//         "isActive": isActive,
//       };
// }
