import 'dart:convert';

ApplicationModel applicationModelFromJson(String str) =>
    ApplicationModel.fromJson(json.decode(str));

String applicationModelToJson(ApplicationModel data) =>
    json.encode(data.toJson());

class ApplicationModel {
  final int? id;
  final String? name;
  final String? status;
  final String? image;
  final String? admissionNumber;
  final String? applicationNumber;
  final int? isFirstStd;
  final int? dataId;

  ApplicationModel(
      {this.id,
      this.name,
      this.status,
      this.image,
      this.admissionNumber,
      this.applicationNumber,
      this.dataId,
      this.isFirstStd});

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
          dataId: json['dataId'] == null
              ? null
              : int.tryParse(json['dataId'].toString()),
          id: json["id"],
          name: json["name"],
          status: json["status"],
          image: json["image"],
          admissionNumber: json["admissionNumber"],
          applicationNumber: json["applicationNumber"],
          isFirstStd: json["isFirstStd"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "image": image,
        "isFirstStd": isFirstStd
      };
}
