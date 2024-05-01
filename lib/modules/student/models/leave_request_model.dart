class LeaveRequestJsonModel {
    bool? status;
    List<LeaveRequestModel>? data;
    String? message;

    LeaveRequestJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory LeaveRequestJsonModel.fromJson(Map<String, dynamic> json) => LeaveRequestJsonModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<LeaveRequestModel>.from(json["data"]!.map((x) => LeaveRequestModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class LeaveRequestModel {
    int? id;
    dynamic noOfDays;
    dynamic description;
    DateTime? leaveStartDate;
    DateTime? leaveEndDate;
    int? fkLeaveTypeId;
    String? leaveType;
    String? encodedId;

    LeaveRequestModel({
        this.id,
        this.noOfDays,
        this.description,
        this.leaveStartDate,
        this.leaveEndDate,
        this.fkLeaveTypeId,
        this.leaveType,
        this.encodedId,
    });

    factory LeaveRequestModel.fromJson(Map<String, dynamic> json) => LeaveRequestModel(
        id: json["id"],
        noOfDays: json["noOfDays"],
        description: json["description"],
        leaveStartDate: json["leaveStartDate"] == null ? null : DateTime.parse(json["leaveStartDate"]),
        leaveEndDate: json["leaveEndDate"] == null ? null : DateTime.parse(json["leaveEndDate"]),
        fkLeaveTypeId: json["fkLeaveTypeId"],
        leaveType: json["leaveType"] == null ? null : json["leaveType"]['leaveName'],
        encodedId: json["encodedId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "noOfDays": noOfDays,
        "description": description,
        "leaveStartDate": "${leaveStartDate!.year.toString().padLeft(4, '0')}-${leaveStartDate!.month.toString().padLeft(2, '0')}-${leaveStartDate!.day.toString().padLeft(2, '0')}",
        "leaveEndDate": "${leaveEndDate!.year.toString().padLeft(4, '0')}-${leaveEndDate!.month.toString().padLeft(2, '0')}-${leaveEndDate!.day.toString().padLeft(2, '0')}",
        "fkLeaveTypeId": fkLeaveTypeId,
        // "leaveType": leaveType?.toJson(),
        "encodedId": encodedId,
    };
}

// class LeaveType {
//     int? id;
//     String? leaveDisplayName;
//     String? leaveName;
//     int? createdBy;
//     int? updatedBy;
//     int? isActive;
//     dynamic deletedAt;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     LeaveType({
//         this.id,
//         this.leaveDisplayName,
//         this.leaveName,
//         this.createdBy,
//         this.updatedBy,
//         this.isActive,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
//         id: json["id"],
//         leaveDisplayName: json["leaveDisplayName"],
//         leaveName: json["leaveName"],
//         createdBy: json["createdBy"],
//         updatedBy: json["updatedBy"],
//         isActive: json["isActive"],
//         deletedAt: json["deletedAt"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "leaveDisplayName": leaveDisplayName,
//         "leaveName": leaveName,
//         "createdBy": createdBy,
//         "updatedBy": updatedBy,
//         "isActive": isActive,
//         "deletedAt": deletedAt,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//     };
// }