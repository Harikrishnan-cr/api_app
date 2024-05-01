class LeaveTypesJsonModel {
    bool? status;
    List<LeaveTypesModel>? data;
    String? message;

    LeaveTypesJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory LeaveTypesJsonModel.fromJson(Map<String, dynamic> json) => LeaveTypesJsonModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<LeaveTypesModel>.from(json["data"]!.map((x) => LeaveTypesModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class LeaveTypesModel {
    int? id;
    String? leaveName;
    String? leaveDisplayName;

    LeaveTypesModel({
        this.id,
        this.leaveName,
        this.leaveDisplayName,
    });

    factory LeaveTypesModel.fromJson(Map<String, dynamic> json) => LeaveTypesModel(
        id: json["id"],
        leaveName: json["leaveName"],
        leaveDisplayName: json["leaveDisplayName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "leaveName": leaveName,
        "leaveDisplayName": leaveDisplayName,
    };
}
