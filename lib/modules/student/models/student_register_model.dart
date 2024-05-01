import 'dart:convert';

StudentRegisterModel studentRegisterModelFromJson(String str) =>
    StudentRegisterModel.fromJson(json.decode(str));

String studentRegisterModelToJson(StudentRegisterModel data) =>
    json.encode(data.toJson());

class StudentRegisterModel {
  final String? name;
  final String? dob;
  final String? gender;
  final String? email;
  final String? studentDisplayId;
  final int? createdBy;
  final int? updatedBy;
  final int? fkParentId;
  final int? fkCountryId;
  final int? fkStateId;
  final String? applicationNumber;
  final int? fkUserId;
  final int? joinedClassId;
  final String? tcNo;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? image;
  final dynamic signedPhotoUrl;
  final String? encodedId;
  final String? imageUrl;
  final int? isFirstStd;

  StudentRegisterModel({
    this.name,
    this.dob,
    this.gender,
    this.email,
    this.studentDisplayId,
    this.createdBy,
    this.updatedBy,
    this.fkParentId,
    this.fkCountryId,
    this.fkStateId,
    this.applicationNumber,
    this.fkUserId,
    this.joinedClassId,
    this.tcNo,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
    this.signedPhotoUrl,
    this.encodedId,
    this.imageUrl,
    this.isFirstStd
  });

  factory StudentRegisterModel.fromJson(Map<String, dynamic> json) =>
      StudentRegisterModel(
        name: json["name"],
        dob: json["dob"],
        gender: json["gender"],
        email: json["email"],
        studentDisplayId: json["studentDisplayId"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        fkParentId: json["fkParentId"],
        // fkCountryId: json["fkCountryId"],
        // fkStateId: json["fkStateId"],
        applicationNumber: json["applicationNumber"],
        fkUserId: json["id"],
        // joinedClassId: json["joinedClassId"],
        tcNo: json["tcNo"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"],
        id: json["id"],
        image: json["image"],
        signedPhotoUrl: json["signedPhotoUrl"],
        encodedId: json["encodedId"],
        imageUrl: json["imageUrl"],
        isFirstStd: json["isFirstStd"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob,
        "gender": gender,
        "email": email,
        "studentDisplayId": studentDisplayId,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "fkParentId": fkParentId,
        "fkCountryId": fkCountryId,
        "fkStateId": fkStateId,
        "applicationNumber": applicationNumber,
        "fkUserId": fkUserId,
        "joinedClassId": joinedClassId,
        "tcNo": tcNo,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "id": id,
        "image": image,
        "signedPhotoUrl": signedPhotoUrl,
        "encodedId": encodedId,
        "imageUrl": imageUrl,
        "isFirstStd": isFirstStd
      };
}
