// To parse this JSON data, do
//
//     final studentLoginModel = studentLoginModelFromJson(jsonString);

import 'dart:convert';

StudentLoginModel studentLoginModelFromJson(String str) => StudentLoginModel.fromJson(json.decode(str));

String studentLoginModelToJson(StudentLoginModel data) => json.encode(data.toJson());

class StudentLoginModel {
    final int? id;
    final dynamic name;
    final dynamic email;
    final dynamic phoneNumber;
    final dynamic profilePhotoPath;
    final dynamic twoFactorConfirmedAt;
    final int? isActive;
    final int? isLogin;
    final String? otp;
    final DateTime? otpVerifiedAt;
    final dynamic emailVerifiedAt;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? username;
    final String? status;
    final dynamic remarks;
    final dynamic createdBy;
    final dynamic updatedBy;
    final dynamic dob;
    final dynamic fkCountryId;
    final dynamic fkStateId;
    final dynamic branch;
    final dynamic city;
    final dynamic address;
    final int? isParent;
    final int? isStudent;
    final int? isRegularUser;
    final String? pins;
    final int? roleId;
    final String? roleName;
    final dynamic signedProfilePhotoPath;
    final List<Role>? roles;

    StudentLoginModel({
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
        this.roleId,
        this.roleName,
        this.signedProfilePhotoPath,
        this.roles,
    });

    factory StudentLoginModel.fromJson(Map<String, dynamic> json) => StudentLoginModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePhotoPath: json["profilePhotoPath"],
        twoFactorConfirmedAt: json["twoFactorConfirmedAt"],
        isActive: json["isActive"],
        isLogin: json["isLogin"],
        otp: json["otp"],
        otpVerifiedAt: json["otpVerifiedAt"] == null ? null : DateTime.parse(json["otpVerifiedAt"]),
        emailVerifiedAt: json["emailVerifiedAt"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        roleId: json["roleId"],
        roleName: json["roleName"],
        signedProfilePhotoPath: json["signedProfilePhotoPath"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
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
        "emailVerifiedAt": emailVerifiedAt,
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
        "roleId": roleId,
        "roleName": roleName,
        "signedProfilePhotoPath": signedProfilePhotoPath,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
    };
}

class Role {
    final int? id;
    final String? name;
    final String? guardName;
    final dynamic description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? createdBy;
    final int? updatedBy;
    final Pivot? pivot;

    Role({
        this.id,
        this.name,
        this.guardName,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.pivot,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guardName"],
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guardName": guardName,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "pivot": pivot?.toJson(),
    };
}

class Pivot {
    final String? modelType;
    final int? modelId;
    final int? roleId;

    Pivot({
        this.modelType,
        this.modelId,
        this.roleId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelType: json["modelType"],
        modelId: json["modelId"],
        roleId: json["roleId"],
    );

    Map<String, dynamic> toJson() => {
        "modelType": modelType,
        "modelId": modelId,
        "roleId": roleId,
    };
}
