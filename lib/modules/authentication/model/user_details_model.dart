class UserDetailsJsonModel {
  bool? status;
  UserDetailsModel? data;
  String? message;

  UserDetailsJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory UserDetailsJsonModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : UserDetailsModel.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class UserDetailsModel {
  String? username;
  String? name;
  String? phoneNumber;
  String? email;
  dynamic image;
  dynamic imageUrl;
  String? dob;
  String? gender;
  String? cAddress;
  int? fkCountryId;
  int? fkStateId;
  String? address;
  int? fkCStateId;
  int? fkCCountryId;
  DateTime? otpVerifiedAt;
  int? isActive;
  String? status;

  UserDetailsModel({
    this.username,
    this.name,
    this.phoneNumber,
    this.email,
    this.image,
    this.imageUrl,
    this.dob,
    this.gender,
    this.cAddress,
    this.fkCountryId,
    this.fkStateId,
    this.address,
    this.fkCStateId,
    this.fkCCountryId,
    this.otpVerifiedAt,
    this.isActive,
    this.status,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        username: json["username"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        image: json["image"],
        imageUrl: json["imageUrl"],
        dob: json["dob"],
        gender: json["gender"],
        cAddress: json["cAddress"],
        fkCountryId: json["fkCountryId"],
        fkStateId: json["fkStateId"],
        address: json["address"],
        fkCStateId: json["fkCStateId"],
        fkCCountryId: json["fkCCountryId"],
        otpVerifiedAt: json["otpVerifiedAt"] == null
            ? null
            : DateTime.parse(json["otpVerifiedAt"]),
        isActive: json["isActive"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "image": image,
        "imageUrl": imageUrl,
        "dob": dob,
        "gender": gender,
        "cAddress": cAddress,
        "fkCountryId": fkCountryId,
        "fkStateId": fkStateId,
        "address": address,
        "fkCStateId": fkCStateId,
        "fkCCountryId": fkCCountryId,
        "otpVerifiedAt": otpVerifiedAt?.toIso8601String(),
        "isActive": isActive,
        "status": status,
      };
}
