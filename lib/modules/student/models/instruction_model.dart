// To parse this JSON data, do
//
//     final instructionModel = instructionModelFromJson(jsonString);

import 'dart:convert';

InstructionModel instructionModelFromJson(String str) => InstructionModel.fromJson(json.decode(str));

String instructionModelToJson(InstructionModel data) => json.encode(data.toJson());

class InstructionModel {
    final int? id;
    final String? title;
    final String? subtitle;
    final List<Instruction>? instructions;

    InstructionModel({
        this.id,
        this.title,
        this.subtitle,
        this.instructions,
    });

    factory InstructionModel.fromJson(Map<String, dynamic> json) => InstructionModel(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        instructions: json["instructions"] == null ? [] : List<Instruction>.from(json["instructions"]!.map((x) => Instruction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "instructions": instructions == null ? [] : List<dynamic>.from(instructions!.map((x) => x.toJson())),
    };
}

class Instruction {
    final String? content;
    final Pivot? pivot;

    Instruction({
        this.content,
        this.pivot,
    });

    factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
        content: json["content"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "pivot": pivot?.toJson(),
    };
}

class Pivot {
    final int? fkInstructionId;
    final int? fkPageId;

    Pivot({
        this.fkInstructionId,
        this.fkPageId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        fkInstructionId: json["fkInstructionId"],
        fkPageId: json["fkPageId"],
    );

    Map<String, dynamic> toJson() => {
        "fkInstructionId": fkInstructionId,
        "fkPageId": fkPageId,
    };
}

class SimpleInstructionModel {
    bool? status;
    List<String>? data;
    String? message;

    SimpleInstructionModel({
        this.status,
        this.data,
        this.message,
    });

    factory SimpleInstructionModel.fromJson(Map<String, dynamic> json) => SimpleInstructionModel(
        status: json["status"],
        data: json["data"]["data"] == null ? [] : List<String>.from(json["data"]["data"]!.map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
    };
}

// class InstructionList {
//     List<String>? data;

//     InstructionList({
//         this.data,
//     });

//     factory InstructionList.fromJson(Map<String, dynamic> json) => InstructionList(
//         data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
//     };
// }
