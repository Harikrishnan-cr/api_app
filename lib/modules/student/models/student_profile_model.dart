// To parse this JSON data, do
//
//     final studentProfileModel = studentProfileModelFromJson(jsonString);

import 'dart:convert';

StudentProfileModel studentProfileModelFromJson(String str) =>
    StudentProfileModel.fromJson(json.decode(str));

String studentProfileModelToJson(StudentProfileModel data) =>
    json.encode(data.toJson());

class StudentProfileModel {
  final int? id;
  final String? admissionNo;
  final String? name;
  final dynamic image;
  final int? batchId;
  final String? batchName;
  final dynamic classId;
  final String? className;

  StudentProfileModel({
    this.id,
    this.admissionNo,
    this.name,
    this.image,
    this.batchId,
    this.batchName,
    this.classId,
    this.className,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) =>
      StudentProfileModel(
        id: json["id"],
        admissionNo: json["admissionNo"],
        name: json["name"],
        image: json["image"],
        batchId: json["batchId"],
        batchName: json["batchName"],
        classId: json["classId"],
        className: json["className"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admissionNo": admissionNo,
        "name": name,
        "image": image,
        "batchId": batchId,
        "batchName": batchName,
        "classId": classId,
        "className": className,
      };
}

class PasswordResetRespJsonModel {
  bool? status;
  // PasswordResetRespModel? data;
  String? message;

  PasswordResetRespJsonModel({
    this.status,
    // this.data,
    this.message,
  });

  factory PasswordResetRespJsonModel.fromJson(Map<String, dynamic> json) =>
      PasswordResetRespJsonModel(
        status: json["status"],
        // data: json["data"] == null ? null : PasswordResetRespModel.fromJson(json["data"]),
        message: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        // "data": data?.toJson(),
        "data": message,
      };
}

class PasswordResetRespModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  dynamic profilePhotoPath;
  dynamic twoFactorConfirmedAt;
  int? isActive;
  int? isLogin;
  dynamic otp;
  DateTime? otpVerifiedAt;
  DateTime? emailVerifiedAt;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;
  String? status;
  dynamic remarks;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic dob;
  dynamic fkCountryId;
  dynamic fkStateId;
  dynamic branch;
  dynamic city;
  dynamic address;
  int? isParent;
  int? isStudent;
  int? isRegularUser;
  String? pins;
  dynamic signedProfilePhotoPath;

  PasswordResetRespModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePhotoPath,
    this.twoFactorConfirmedAt,
    this.isActive,
    this.isLogin,
    this.otp,
    this.otpVerifiedAt,
    this.emailVerifiedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.status,
    this.remarks,
    this.createdBy,
    this.updatedBy,
    this.dob,
    this.fkCountryId,
    this.fkStateId,
    this.branch,
    this.city,
    this.address,
    this.isParent,
    this.isStudent,
    this.isRegularUser,
    this.pins,
    this.signedProfilePhotoPath,
  });

  factory PasswordResetRespModel.fromJson(Map<String, dynamic> json) =>
      PasswordResetRespModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePhotoPath: json["profilePhotoPath"],
        twoFactorConfirmedAt: json["twoFactorConfirmedAt"],
        isActive: json["isActive"],
        isLogin: json["isLogin"],
        otp: json["otp"],
        otpVerifiedAt: json["otpVerifiedAt"] == null
            ? null
            : DateTime.parse(json["otpVerifiedAt"]),
        emailVerifiedAt: json["emailVerifiedAt"] == null
            ? null
            : DateTime.parse(json["emailVerifiedAt"]),
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        username: json["username"],
        status: json["status"],
        remarks: json["remarks"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        dob: json["dob"],
        fkCountryId: json["fkCountryId"],
        fkStateId: json["fkStateId"],
        branch: json["branch"],
        city: json["city"],
        address: json["address"],
        isParent: json["isParent"],
        isStudent: json["isStudent"],
        isRegularUser: json["isRegularUser"],
        pins: json["pins"],
        signedProfilePhotoPath: json["signedProfilePhotoPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePhotoPath": profilePhotoPath,
        "twoFactorConfirmedAt": twoFactorConfirmedAt,
        "isActive": isActive,
        "isLogin": isLogin,
        "otp": otp,
        "otpVerifiedAt": otpVerifiedAt?.toIso8601String(),
        "emailVerifiedAt": emailVerifiedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "username": username,
        "status": status,
        "remarks": remarks,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "dob": dob,
        "fkCountryId": fkCountryId,
        "fkStateId": fkStateId,
        "branch": branch,
        "city": city,
        "address": address,
        "isParent": isParent,
        "isStudent": isStudent,
        "isRegularUser": isRegularUser,
        "pins": pins,
        "signedProfilePhotoPath": signedProfilePhotoPath,
      };
}
