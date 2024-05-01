class ExamsJsonModel {
  bool? status;
  List<ExamsModel>? data;
  String? message;

  ExamsJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory ExamsJsonModel.fromJson(Map<String, dynamic> json) => ExamsJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ExamsModel>.from(
                json["data"]!.map((x) => ExamsModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class ExamsModel {
  int? id;
  String? examDisplayId;
  String? name;
  dynamic examDate;
  String? description;
  String? photoUrl;
  String? status;
  DateTime? completedDate;
  String? image;
  int? examId;
  String? encodedId;
  dynamic examStudent;

  ExamsModel({
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

  @override
  String toString() {
    return 'ExamsModel{id: $id, examDisplayId: $examDisplayId, name: $name, '
        'examDate: $examDate, description: $description, photoUrl: $photoUrl, '
        'status: $status, completedDate: $completedDate, image: $image, '
        'examId: $examId, encodedId: $encodedId, examStudent: $examStudent}';
  }

  factory ExamsModel.fromJson(Map<String, dynamic> json) => ExamsModel(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        name: json["name"],
        examDate: json["examDate"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        status: json["status"],
        completedDate: json["completedDate"] == null
            ? null
            : DateTime.parse(json["completedDate"]),
        image: json["image"],
        examId: json["examId"],
        encodedId: json["encodedId"],
        examStudent: json["examStudent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "name": name,
        "examDate": examDate,
        "description": description,
        "photoUrl": photoUrl,
        "status": status,
        "completedDate":
            "${completedDate!.year.toString().padLeft(4, '0')}-${completedDate!.month.toString().padLeft(2, '0')}-${completedDate!.day.toString().padLeft(2, '0')}",
        "image": image,
        "examId": examId,
        "encodedId": encodedId,
        "examStudent": examStudent,
      };
}
