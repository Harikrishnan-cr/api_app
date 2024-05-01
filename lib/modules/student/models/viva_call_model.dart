// To parse this JSON data, do
//
//     final vivaCallModel = vivaCallModelFromJson(jsonString);

import 'dart:convert';

VivaCallModel vivaCallModelFromJson(String str) => VivaCallModel.fromJson(json.decode(str));

String vivaCallModelToJson(VivaCallModel data) => json.encode(data.toJson());

class VivaCallModel {
    final int? id;
    final String? zoomLink;
    final String? status;

    VivaCallModel({
        this.id,
        this.zoomLink,
        this.status,
    });

    factory VivaCallModel.fromJson(Map<String, dynamic> json) => VivaCallModel(
        id: json["id"],
        zoomLink: json["zoomLink"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "zoomLink": zoomLink,
        "status": status,
    };
}
