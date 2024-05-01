

import 'dart:convert';

McqInstructionModel mcqInstructionModelFromJson(String str) => McqInstructionModel.fromJson(json.decode(str));

String mcqInstructionModelToJson(McqInstructionModel data) => json.encode(data.toJson());

class McqInstructionModel {
    final int id;
    final String examDisplayId;
    final String instructions;
    final String? image;
    final String encodedId;

    McqInstructionModel({
        required this.id,
        required this.examDisplayId,
        required this.instructions,
        required this.image,
        required this.encodedId,
    });

    factory McqInstructionModel.fromJson(Map<String, dynamic> json) => McqInstructionModel(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        instructions: json["instructions"],
        image: json["image"],
        encodedId: json["encodedId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "instructions": instructions,
        "image": image,
        "encodedId": encodedId,
    };
}
