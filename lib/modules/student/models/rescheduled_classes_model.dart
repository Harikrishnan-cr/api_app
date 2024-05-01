class RescheduledClassesJsonModel {
    List<DateTime>? dates;
    List<RescheduledClassesModel>? data;

    RescheduledClassesJsonModel({
        this.dates,
        this.data,
    });

    factory RescheduledClassesJsonModel.fromJson(Map<String, dynamic> json) => RescheduledClassesJsonModel(
        dates: json["dates"] == null ? [] : List<DateTime>.from(json["dates"]!.map((x) => DateTime.parse(x))),
        data: json["rescheduledClass"] == null ? [] : List<RescheduledClassesModel>.from(json["rescheduledClass"]!.map((x) => RescheduledClassesModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "dates": dates == null ? [] : List<dynamic>.from(dates!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "rescheduledClass": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RescheduledClassesModel {
    int? id;
    DateTime? date;
    String? batchName;
    int? batchId;
    List<Subject>? subjects;
    List<AvailableTimeSlot>? availableTime;

    RescheduledClassesModel({
        this.id,
        this.date,
        this.batchName,
        this.batchId,
        this.subjects,
        this.availableTime,
    });

    factory RescheduledClassesModel.fromJson(Map<String, dynamic> json) => RescheduledClassesModel(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        batchName: json["batchName"],
        batchId: json["batchId"],
        subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
        availableTime: json["availableTime"] == null ? [] : List<AvailableTimeSlot>.from(json["availableTime"]!.map((x) => AvailableTimeSlot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "batchName": batchName,
        "batchId": batchId,
        "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "availableTime": availableTime == null ? [] : List<dynamic>.from(availableTime!.map((x) => x.toJson())),
    };
}

class AvailableTimeSlot {
    int? id;
    String? name;

    AvailableTimeSlot({
        this.id,
        this.name,
    });

    factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) => AvailableTimeSlot(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Subject {
    int? id;
    String? title;
    String? signedPhotoUrl;
    List<Lesson>? lessons;

    Subject({
        this.id,
        this.title,
        this.signedPhotoUrl,
        this.lessons,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        title: json["title"],
        signedPhotoUrl: json["signedPhotoUrl"],
        lessons: json["lessons"] == null ? [] : List<Lesson>.from(json["lessons"]!.map((x) => Lesson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "signedPhotoUrl": signedPhotoUrl,
        "lessons": lessons == null ? [] : List<dynamic>.from(lessons!.map((x) => x.toJson())),
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

class RescheduleSubmitResponse {
    bool? status;
    String? data;

    RescheduleSubmitResponse({
        this.status,
        this.data,
    });

    factory RescheduleSubmitResponse.fromJson(Map<String, dynamic> json) => RescheduleSubmitResponse(
        status: json["status"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
    };
}