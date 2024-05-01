class MarkSheetJsonModel {
    bool? status;
    MarkSheetModel? data;
    String? message;

    MarkSheetJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory MarkSheetJsonModel.fromJson(Map<String, dynamic> json) => MarkSheetJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : MarkSheetModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class MarkSheetModel {
    int? id;
    int? passMark;
    int? mark;
    String? resultStatus;
    num? correctAnswers, wrongAnswers;

    MarkSheetModel({
        this.id,
        this.passMark,
        this.mark,
        this.resultStatus,
    });

    factory MarkSheetModel.fromJson(Map<String, dynamic> json) => MarkSheetModel(
        id: json["id"],
        passMark: json["passMark"],
        mark: json["mark"],
        resultStatus: json["resultStatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "passMark": passMark,
        "mark": mark,
        "resultStatus": resultStatus,
    };
}
