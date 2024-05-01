import 'dart:io';

class AssignmentDetailsJsonModel {
    bool? status;
    AssignmentDetailsModel? data;
    String? message;

    AssignmentDetailsJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory AssignmentDetailsJsonModel.fromJson(Map<String, dynamic> json) => AssignmentDetailsJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : AssignmentDetailsModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class AssignmentDetailsModel {
    int? id;
    String? title;
    String? subTitle;
    String? description;
    List<String>? instructions;
    DateTime? submissionDate;
    String? photoUrl;
    String? imageUrl;
    List<WorkSheet>? workSheets;

    AssignmentDetailsModel({
        this.id,
        this.title,
        this.subTitle,
        this.description,
        this.instructions,
        this.submissionDate,
        this.photoUrl,
        this.workSheets,
        this.imageUrl
    });

    factory AssignmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      AssignmentDetailsModel(
        id: json["id"],
        title: json["title"],
        subTitle: json["subTitle"],
        description: json["description"],
        instructions: json["instructions"] != null
            ? List<String>.from(
                json["instructions"]!.map((x) => (x)))
            : [],
        submissionDate: json["submissionDate"] == null
            ? null
            : DateTime.parse(json["submissionDate"]),
        photoUrl: json["photoUrl"],
        imageUrl: json["imageUrl"],
        workSheets: json["workSheets"] == null
            ? []
            : List<WorkSheet>.from(
                json["workSheets"]!.map((x) => WorkSheet.fromJson(x))),
      );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "instructions": instructions,
        "submissionDate": submissionDate?.toIso8601String(),
        "photoUrl": photoUrl,
        "workSheets": workSheets == null ? [] : List<dynamic>.from(workSheets!.map((x) => x.toJson())),
    };
}

class WorkSheet {
    int? id;
    String? worksheetUrl;
    String? name;
    String? worksheet;
    String? signedWorksheetUrl;
    File? answerWorksheet;
    String? status;

    WorkSheet({
        this.id,
        this.worksheetUrl,
        this.name,
        this.worksheet,
        this.signedWorksheetUrl,
        this.answerWorksheet,
        this.status
    });

    factory WorkSheet.fromJson(Map<String, dynamic> json) => WorkSheet(
        id: json["id"],
        worksheetUrl: json["worksheetUrl"],
        name: json["name"],
        worksheet: json["worksheet"],
        signedWorksheetUrl: json["signedWorksheetUrl"],
        status: json["status"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "worksheetUrl": worksheetUrl,
        "name": name,
        "worksheet": worksheet,
        "signedWorksheetUrl": signedWorksheetUrl,
        "status": status
    };
}
