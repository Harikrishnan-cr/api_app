// To parse this JSON data, do
//
//     final usthadModel = usthadModelFromJson(jsonString);

import 'dart:convert';

UsthadModel usthadModelFromJson(String str) =>
    UsthadModel.fromJson(json.decode(str));

String usthadModelToJson(UsthadModel data) => json.encode(data.toJson());

class UsthadModel {
  final int? id;
  final String? name;
  final String? photoUrl;
  final String? photo;
  final String? image;
  final String? signedPhotoUrl;
  final String? about;
  final String? qualification;
  final String? experience;

  UsthadModel({
    this.id,
    this.name,
    this.photoUrl,
    this.photo,
    this.image,
    this.signedPhotoUrl,
    this.about,
    this.qualification,
    this.experience
  });

  factory UsthadModel.fromJson(Map<String, dynamic> json) => UsthadModel(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        photo: json["photo"],
        image: json["image"],
        signedPhotoUrl: json["signedPhotoUrl"],
        about: json["about"],
        experience: json["experience"],
        qualification: json["qualification"] == null
            ? null
            : json['qualification']['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "photo": photo,
        "image": image,
        "signedPhotoUrl": signedPhotoUrl,
      };
}
