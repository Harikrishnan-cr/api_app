class ExamInstructionsJsonModel {
    bool? status;
    List<ExamInstructionsModel>? data;
    String? message;

    ExamInstructionsJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory ExamInstructionsJsonModel.fromJson(Map<String, dynamic> json) => ExamInstructionsJsonModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<ExamInstructionsModel>.from(json["data"]!.map((x) => ExamInstructionsModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class ExamInstructionsModel {
    int? id;
    String? examDisplayId;
    String? name;
    String? description;
    List<String>? instructions;
    String? encodedId;

    ExamInstructionsModel({
        this.id,
        this.examDisplayId,
        this.name,
        this.description,
        this.instructions,
        this.encodedId,
    });

    factory ExamInstructionsModel.fromJson(Map<String, dynamic> json) => ExamInstructionsModel(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        name: json["name"],
        description: json["description"],
        instructions: json["instructions"] == null ? [] : List<String>.from(json["instructions"]!.map((x) => x)),
        encodedId: json["encodedId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "name": name,
        "description": description,
        "instructions": instructions,
        "encodedId": encodedId,
    };
}
