class AssignmentSubmitJsonModel {
    bool? status;
    AssignmentSubmitResponseModel? data;
    String? message;

    AssignmentSubmitJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory AssignmentSubmitJsonModel.fromJson(Map<String, dynamic> json) => AssignmentSubmitJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : AssignmentSubmitResponseModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class AssignmentSubmitResponseModel {
    String? fkAssignmentId;
    String? fkStudentId;
    String? status;
    DateTime? submittedDate;
    int? createdBy;
    int? updatedBy;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    AssignmentSubmitResponseModel({
        this.fkAssignmentId,
        this.fkStudentId,
        this.status,
        this.submittedDate,
        this.createdBy,
        this.updatedBy,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory AssignmentSubmitResponseModel.fromJson(Map<String, dynamic> json) => AssignmentSubmitResponseModel(
        fkAssignmentId: json["fkAssignmentId"],
        fkStudentId: json["fkStudentId"],
        status: json["status"],
        submittedDate: json["submittedDate"] == null ? null : DateTime.parse(json["submittedDate"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "fkAssignmentId": fkAssignmentId,
        "fkStudentId": fkStudentId,
        "status": status,
        "submittedDate": "${submittedDate!.year.toString().padLeft(4, '0')}-${submittedDate!.month.toString().padLeft(2, '0')}-${submittedDate!.day.toString().padLeft(2, '0')}",
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "id": id,
    };
}

class AssignmentSubmitResponse {
    bool? status;
    String? data;
    String? message;

    AssignmentSubmitResponse({
        this.status,
        this.data,
        this.message,
    });

    factory AssignmentSubmitResponse.fromJson(Map<String, dynamic> json) => AssignmentSubmitResponse(
        status: json["status"],
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
    };
}
