// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  final int? id;
  final String? link;
  final String? image;

  final String? imageUrl;
  BannerModel({this.id, this.link, this.image, this.imageUrl});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
      id: json["id"],
      link: json["link"],
      image: json["image"],
      imageUrl: json["imageUrl"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "link": link, "image": image, "imageUrl": imageUrl};
}
