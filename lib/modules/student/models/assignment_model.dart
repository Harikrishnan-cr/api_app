// class AssignmentJsonModel {
//   bool? status;
//   List<AssignmentModel>? data;
//   String? message;

//   AssignmentJsonModel({
//     this.status,
//     this.data,
//     this.message,
//   });

//   factory AssignmentJsonModel.fromJson(Map<String, dynamic> json) =>
//       AssignmentJsonModel(
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<AssignmentModel>.from(
//                 json["data"]!.map((x) => AssignmentModel.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class AssignmentModel {
//   int? id;
//   String? title;
//   String? description;
//   DateTime? submissionDate;
//   String? photoUrl;
//   String? status;
//   String? image;
//   String? signedPhotoUrl;
//   num? mark;

//   AssignmentModel(
//       {this.id,
//       this.title,
//       this.description,
//       this.submissionDate,
//       this.photoUrl,
//       this.status,
//       this.image,
//       this.signedPhotoUrl,
//       this.mark});

//   factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
//       AssignmentModel(
//         id: json["id"],
//         title: json["title"],
//         mark: json['fkStudentId'],
//         description: json["description"],
//         submissionDate: json["submissionDate"] == null
//             ? null
//             : DateTime.parse(json["submissionDate"]),
//         photoUrl: json["photoUrl"],
//         status: json["status"],
//         image: json["image"],
//         signedPhotoUrl: json["signedPhotoUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "submissionDate": submissionDate?.toIso8601String(),
//         "photoUrl": photoUrl,
//         "status": status,
//         "image": image,
//         "signedPhotoUrl": signedPhotoUrl,
//       };
// }

// To parse this JSON data, do
//
//     final assignmentModel = assignmentModelFromJson(jsonString);

import 'dart:convert';

AssignmentModelClass assignmentModelFromJson(String str) =>
    AssignmentModelClass.fromJson(json.decode(str));

String assignmentModelToJson(AssignmentModelClass data) =>
    json.encode(data.toJson());

class AssignmentModelClass {
  bool? status;
  Data? data;
  String? message;

  AssignmentModelClass({
    this.status,
    this.data,
    this.message,
  });

  factory AssignmentModelClass.fromJson(Map<String, dynamic> json) =>
      AssignmentModelClass(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? studentId;
  List<AssignmentModel>? assignments;

  Data({
    this.studentId,
    this.assignments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        studentId: json["studentId"],
        assignments: json["assignments"] == null
            ? []
            : List<AssignmentModel>.from(
                json["assignments"]!.map((x) => AssignmentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "assignments": assignments == null
            ? []
            : List<dynamic>.from(assignments!.map((x) => x.toJson())),
      };
}

class AssignmentModel {
  int? id;
  String? title;
  String? description;
  DateTime? submissionDate;
  String? photoUrl;
  String? status;
  DateTime? submittedDate;
  String? image;
  String? signedPhotoUrl;
  Submission? submission;

  AssignmentModel({
    this.id,
    this.title,
    this.description,
    this.submissionDate,
    this.photoUrl,
    this.status,
    this.submittedDate,
    this.image,
    this.signedPhotoUrl,
    this.submission,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        // submissionDate: json["submissionDate"],
        submissionDate: json["submissionDate"] == null
            ? null
            : DateTime.parse(json["submissionDate"]),
        photoUrl: json["photoUrl"],
        status: json["status"],
        submittedDate: json["submittedDate"] == null
            ? null
            : DateTime.parse(json["submittedDate"]),
        image: json["image"],
        signedPhotoUrl: json["signedPhotoUrl"],
        submission: json["submission"] == null
            ? null
            : Submission.fromJson(json["submission"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "submissionDate": submissionDate,
        "photoUrl": photoUrl,
        "status": status,
        "submittedDate":
            "${submittedDate!.year.toString().padLeft(4, '0')}-${submittedDate!.month.toString().padLeft(2, '0')}-${submittedDate!.day.toString().padLeft(2, '0')}",
        "image": image,
        "signedPhotoUrl": signedPhotoUrl,
        "submission": submission?.toJson(),
      };
}

class Submission {
  int? id;
  int? fkAssignmentId;
  int? fkStudentId;
  dynamic submittedWorks;
  dynamic fkRegularStudentId;
  String? status;
  int? mark;
  DateTime? submittedDate;
  int? createdBy;
  int? updatedBy;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? remark;

  Submission({
    this.id,
    this.fkAssignmentId,
    this.fkStudentId,
    this.submittedWorks,
    this.fkRegularStudentId,
    this.status,
    this.mark,
    this.submittedDate,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.remark,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json["id"],
        fkAssignmentId: json["fkAssignmentId"],
        fkStudentId: json["fkStudentId"],
        submittedWorks: json["submittedWorks"],
        fkRegularStudentId: json["fkRegularStudentId"],
        status: json["status"],
        mark: json["mark"],
        submittedDate: json["submittedDate"] == null
            ? null
            : DateTime.parse(json["submittedDate"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fkAssignmentId": fkAssignmentId,
        "fkStudentId": fkStudentId,
        "submittedWorks": submittedWorks,
        "fkRegularStudentId": fkRegularStudentId,
        "status": status,
        "mark": mark,
        "submittedDate":
            "${submittedDate!.year.toString().padLeft(4, '0')}-${submittedDate!.month.toString().padLeft(2, '0')}-${submittedDate!.day.toString().padLeft(2, '0')}",
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "deletedAt": deletedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "remark": remark,
      };
}
