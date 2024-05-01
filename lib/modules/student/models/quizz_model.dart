class QuizzResponseJsonModel {
    bool? status;
    List<QuizzModel>? data;
    String? message;

    QuizzResponseJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory QuizzResponseJsonModel.fromJson(Map<String, dynamic> json) => QuizzResponseJsonModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<QuizzModel>.from(json["data"]!.map((x) => QuizzModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class QuizzModel {
    int? id;
    String? examDisplayId;
    String? name;
    dynamic examDate;
    String? description;
    String? photoUrl;
    String? status;
    DateTime? completedDate;
    dynamic image;
    dynamic examId;
    String? encodedId;
    ExamStudent? examStudent;

    QuizzModel({
        this.id,
        this.examDisplayId,
        this.name,
        this.examDate,
        this.description,
        this.photoUrl,
        this.status,
        this.completedDate,
        this.image,
        this.examId,
        this.encodedId,
        this.examStudent,
    });

    factory QuizzModel.fromJson(Map<String, dynamic> json) => QuizzModel(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        name: json["name"],
        examDate: json["examDate"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        status: json["status"],
        completedDate: json["completedDate"] == null ? null : DateTime.parse(json["completedDate"]),
        image: json["image"],
        examId: json["examId"],
        encodedId: json["encodedId"],
        examStudent: json["examStudent"] == null ? null : ExamStudent.fromJson(json["examStudent"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "name": name,
        "examDate": examDate,
        "description": description,
        "photoUrl": photoUrl,
        "status": status,
        "completedDate": "${completedDate!.year.toString().padLeft(4, '0')}-${completedDate!.month.toString().padLeft(2, '0')}-${completedDate!.day.toString().padLeft(2, '0')}",
        "image": image,
        "examId": examId,
        "encodedId": encodedId,
        "examStudent": examStudent?.toJson(),
    };
}

class ExamStudent {
    int? id;
    int? fkExamPoolId;
    int? fkStudentId;
    dynamic fkRegularStudentId;
    dynamic fkBatchStudentId;
    dynamic fkCourseId;
    String? status;
    int? mark;
    DateTime? attendedDate;
    dynamic uniqueId;
    String? resultStatus;
    int? createdBy;
    int? updatedBy;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    double? timeTakenMin;
    int? fkClassId;

    ExamStudent({
        this.id,
        this.fkExamPoolId,
        this.fkStudentId,
        this.fkRegularStudentId,
        this.fkBatchStudentId,
        this.fkCourseId,
        this.status,
        this.mark,
        this.attendedDate,
        this.uniqueId,
        this.resultStatus,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.timeTakenMin,
        this.fkClassId,
    });

    factory ExamStudent.fromJson(Map<String, dynamic> json) => ExamStudent(
        id: json["id"],
        fkExamPoolId: json["fkExamPoolId"],
        fkStudentId: json["fkStudentId"],
        fkRegularStudentId: json["fkRegularStudentId"],
        fkBatchStudentId: json["fkBatchStudentId"],
        fkCourseId: json["fkCourseId"],
        status: json["status"],
        mark: json["mark"],
        attendedDate: json["attendedDate"] == null ? null : DateTime.parse(json["attendedDate"]),
        uniqueId: json["uniqueId"],
        resultStatus: json["resultStatus"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        timeTakenMin: double.parse( json["timeTakenMin"].toString()),
        fkClassId: json["fkClassId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fkExamPoolId": fkExamPoolId,
        "fkStudentId": fkStudentId,
        "fkRegularStudentId": fkRegularStudentId,
        "fkBatchStudentId": fkBatchStudentId,
        "fkCourseId": fkCourseId,
        "status": status,
        "mark": mark,
        "attendedDate": "${attendedDate!.year.toString().padLeft(4, '0')}-${attendedDate!.month.toString().padLeft(2, '0')}-${attendedDate!.day.toString().padLeft(2, '0')}",
        "uniqueId": uniqueId,
        "resultStatus": resultStatus,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "timeTakenMin": timeTakenMin,
        "fkClassId": fkClassId,
    };
}
