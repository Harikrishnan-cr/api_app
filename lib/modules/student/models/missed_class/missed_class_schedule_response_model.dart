class ScheduleMissedRespJsonModel {
    bool? status;
    ScheduleMissedRespDataModel? data;
    String? message;

    ScheduleMissedRespJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory ScheduleMissedRespJsonModel.fromJson(Map<String, dynamic> json) => ScheduleMissedRespJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : ScheduleMissedRespDataModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class ScheduleMissedRespDataModel {
    ScheduleMissedRespModelData? data;
    int? studentId;

    ScheduleMissedRespDataModel({
        this.data,
        this.studentId,
    });

    factory ScheduleMissedRespDataModel.fromJson(Map<String, dynamic> json) => ScheduleMissedRespDataModel(
        data: json["data"] == null ? null : ScheduleMissedRespModelData.fromJson(json["data"]),
        studentId: json["studentId"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "studentId": studentId,
    };
}

class ScheduleMissedRespModelData {
    int? fkOneToOneClassId;
    int? fkStudentId;
    int? fkBatchId;
    String? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    ScheduleMissedRespModelData({
        this.fkOneToOneClassId,
        this.fkStudentId,
        this.fkBatchId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory ScheduleMissedRespModelData.fromJson(Map<String, dynamic> json) => ScheduleMissedRespModelData(
        fkOneToOneClassId: json["fkOneToOneClassId"],
        fkStudentId: json["fkStudentId"],
        fkBatchId: json["fkBatchId"],
        status: json["status"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "fkOneToOneClassId": fkOneToOneClassId,
        "fkStudentId": fkStudentId,
        "fkBatchId": fkBatchId,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "id": id,
    };
}
