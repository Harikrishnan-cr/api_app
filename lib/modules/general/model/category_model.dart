// To parse this JSON data, do
//
//     final categoiryModel = categoiryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoiryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  final int? id;
  final String? name;
  final String? title;
  final int? isFirstStandard;

  CategoryModel({
    this.id,
    this.name,
    this.title,
    this.isFirstStandard
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        isFirstStandard: json["isFirstStandard"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "classDisplayId": title,
        "isFirstStandard": isFirstStandard
      };

  @override
  String toString() {
    return title ?? name ?? '';
  }
}
