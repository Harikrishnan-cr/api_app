// To parse this JSON data, do
//
//     final kidsModel = kidsModelFromJson(jsonString);

import 'dart:convert';

KidsModel kidsModelFromJson(String str) => KidsModel.fromJson(json.decode(str));

String kidsModelToJson(KidsModel data) => json.encode(data.toJson());

class KidsModel {
  final int? id;
  final String? name;
  final String? image;
  final dynamic signedPhotoUrl;
  final String? encodedId;
  final String? imageUrl;
  final String? role;
  final dynamic admissionNumber;

  KidsModel(
      {this.id,
      this.role,
      this.name,
      this.image,
      this.signedPhotoUrl,
      this.encodedId,
      this.imageUrl,
      this.admissionNumber});

  factory KidsModel.fromJson(Map<String, dynamic> json) => KidsModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      role: json['role'],
      signedPhotoUrl: json["signedPhotoUrl"],
      encodedId: json["encodedId"],
      imageUrl: json["imageUrl"],
      admissionNumber: json["admissionNumber"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "signedPhotoUrl": signedPhotoUrl,
        "encodedId": encodedId,
        "imageUrl": imageUrl,
      };
}
