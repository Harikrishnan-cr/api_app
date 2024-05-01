// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  final int? id;
  final String? title;
  final String? courseDisplayId;
  final String? description;
  final num? price;
  final String? courseDuration;
  final int? isPopular;
  final String? photoUrl;
  final String? whatWillLearn;
  final String? image;
  final String? courseLink;
  final bool? paidStatus;

  CourseModel(
      {this.id,
      this.title,
      this.paidStatus,
      this.courseDisplayId,
      this.description,
      this.price,
      this.courseDuration,
      this.isPopular,
      this.photoUrl,
      this.whatWillLearn,
      this.image,
      this.courseLink});

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
      id: json["id"],
      title: json["title"],
      courseDisplayId: json["courseDisplayId"],
      description: json["description"],
      price: json["price"],
      paidStatus: json['paidStatus'] == 'paid' ? true : false,
      courseDuration: json["courseDuration"],
      isPopular: json["isPopular"],
      whatWillLearn: json["whatWillLearn"],
      photoUrl: json["photoUrl"],
      image: json["image"],
      courseLink: json["courseLink"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "courseDisplayId": courseDisplayId,
        "description": description,
        "price": price,
        "courseDuration": courseDuration,
        "isPopular": isPopular,
        "image": image
      };
}
