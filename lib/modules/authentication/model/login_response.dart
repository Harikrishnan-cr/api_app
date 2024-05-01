// To parse this JSON data, do
//
//      loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profileImage;
  int? isActive;
  int? isLogin;
  String? otp;
  String? username;
  String? status;
  // 1=parent
  // 2= student
  String? role;
  String? accessToken;
  String? refreshToken;

  DateTime? dob;

  String? gender;

  String? homeAddress;

  bool? isSameAddress;

  String? communicationAddress;

  int? homeCountryId;
  int? communicationCountryId;

  int? homeStateId;
  int? communicationStateId;
  int? isParent;
  int? isStudent;
  int? isRegularUser;

  bool? pinSet;

  LoginResponse({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.isActive,
    this.isLogin,
    this.otp,
    this.username,
    this.status,
    this.role,
    this.accessToken,
    this.refreshToken,
    this.isParent,
    this.isRegularUser,
    this.isStudent,
    this.pinSet,
    this.dob
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"],
        isActive: json["isActive"],
        isLogin: json["isLogin"],
        otp: json["otpVerifiedAt"],
        username: json["username"],
        status: json["status"],
        role: json["roleName"] ?? 'guest',
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        isParent: json["isParent"],
        isRegularUser: json["isRegularUser"],
        isStudent: json["isStudent"],
        dob: json["dob"]!=null ? DateTime.parse(json["dob"]) : null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profileImage": profileImage,
        "isActive": isActive,
        "isLogin": isLogin,
        "otpVerifiedAt": otp,
        "username": username,
        "status": status,
        "roleName": role,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "dob": dob?.toIso8601String(),
        "gender": gender,
        "home_address": homeAddress,
        "is_same_address": isSameAddress,
        "communication_address": communicationAddress,
        "home_state": homeStateId,
        "home_country": homeCountryId,
        "communication_state": communicationStateId,
        "communication_country": communicationCountryId,
        "mobile": phoneNumber,
        "isParent": isParent,
        "isStudent": isStudent,
        "isRegularUser": isRegularUser,
      };
}
