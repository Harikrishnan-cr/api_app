// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? employeeId;
  int? propertyId;
  RoleType? roleType;
  String? name;
  String? email;
  String? countryCode;
  String? mobile;
  String? imgUrl;
  String? gender;
  dynamic dob;
  dynamic address;
  dynamic ctc;
  int? isAllowLogin;
  int? fkCountryId;
  int? fkStateId;
  int? fkCityId;
  DateTime? lastLogin;
  int? isOnline;
  int? isActive;
  int? isEnabled;
  int? isBlocked;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? password='';

  UserModel({
    this.password,
    this.id,
    this.employeeId,
    this.propertyId,
    this.roleType,
    this.name,
    this.email,
    this.countryCode,
    this.mobile,
    this.imgUrl,
    this.gender,
    this.dob,
    this.address,
    this.ctc,
    this.isAllowLogin,
    this.fkCountryId,
    this.fkStateId,
    this.fkCityId,
    this.lastLogin,
    this.isOnline,
    this.isActive,
    this.isEnabled,
    this.isBlocked,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        employeeId: json["employee_id"],
        propertyId: json["fk_property_id"],
        roleType:
            // RoleType.frontDesk,
            RoleType.values[json["fk_property_role_id"]],
        name: json["name"],
        email: json["email"],
        countryCode: json["country_code"],
        mobile: json["mobile"],
        imgUrl: json["img_url"],
        gender: json["gender"],
        dob: json["dob"],
        address: json["address"],
        ctc: json["ctc"],
        isAllowLogin: json["is_allow_login"],
        fkCountryId: json["fk_country_id"],
        fkStateId: json["fk_state_id"],
        fkCityId: json["fk_city_id"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        isOnline: json["is_online"],
        isActive: json["is_active"],
        isEnabled: json["is_enabled"],
        isBlocked: json["is_blocked"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "fk_property_id": propertyId,
        "fk_property_role_id": roleType?.index,
        "name": name,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "img_url": imgUrl,
        "gender": gender,
        "dob": dob,
        "address": address,
        "ctc": ctc,
        "is_allow_login": isAllowLogin,
        "fk_country_id": fkCountryId,
        "fk_state_id": fkStateId,
        "fk_city_id": fkCityId,
        "last_login": lastLogin?.toIso8601String(),
        "is_online": isOnline,
        "is_active": isActive,
        "is_enabled": isEnabled,
        "is_blocked": isBlocked,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum RoleType {
  none,
  admin,
  backOffice,
  frontDesk,
  crm,
  hr,
  houseKeeping,
  pos,
  finance
}
