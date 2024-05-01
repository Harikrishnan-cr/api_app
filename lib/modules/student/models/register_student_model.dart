// To parse this JSON data, do
//
//     final registerStudentModel = registerStudentModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

RegisterStudentModel registerStudentModelFromJson(String str) =>
    RegisterStudentModel.fromJson(json.decode(str));

String registerStudentModelToJson(RegisterStudentModel data) =>
    json.encode(data.toJson());

class RegisterStudentModel {
  final int? classId;
  final String? name;
  final DateTime? dob;
  final int? countryId;
  final int? stateId;
  final List<int>? timeslotId;
  final File? studentPhoto;
  final File? birthCertificate;
  final int? isFirstStandard;
  final String? gender;
  // final String? email;
  final String? tcNumber;
  final File? tcFile;

  RegisterStudentModel({
    this.classId,
    this.name,
    this.dob,
    this.countryId,
    this.stateId,
    this.timeslotId,
    this.studentPhoto,
    this.birthCertificate,
    this.isFirstStandard,
    this.gender,
    // this.email,
    this.tcNumber,
    this.tcFile,
  });

  factory RegisterStudentModel.fromJson(Map<String, dynamic> json) =>
      RegisterStudentModel(
        classId: json["class_id"],
        name: json["name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        countryId: json["country_id"],
        stateId: json["state_id"],
        timeslotId: json["timeslot_id"] == null
            ? []
            : List<int>.from(json["timeslot_id"]!.map((x) => x)),
        studentPhoto: json["student_photo"],
        birthCertificate: json["Birth_certificate"],
        isFirstStandard: json["Is_first_standard"],
        gender: json["gender"],
        // email: json["email"],
        tcNumber: json["tc_number"] ?? "",
        tcFile: json["tc_file"],
      );

  Future<FormData> toJson() async {
    String tcFileName =
        tcFile == null ? "" : tcFile?.path.split('/').last ?? "";
    String photoFileName =
        studentPhoto == null ? "" : studentPhoto?.path.split('/').last ?? "";
    String bcFileName = birthCertificate == null
        ? ""
        : birthCertificate?.path.split('/').last ?? "";

    // FormData formData = FormData.fromMap({
    //   "file": await MultipartFile.fromFile(file.path, filename: fileName),
    // });

    var data = FormData.fromMap({
      "class_id": classId,
      "name": name,
      "dob": dob?.toIso8601String(),
      // "dob": DateConverter.paymentHistory(dob!),
      "country_id": countryId,
      "state_id": stateId,
      // "timeslot_id": jsonEncode(timeslotId),
      "student_photo": studentPhoto == null
          ? null
          : await MultipartFile.fromFile(studentPhoto!.path,
              filename: photoFileName),
      "birth_certificate": birthCertificate == null
          ? null
          : await MultipartFile.fromFile(birthCertificate!.path,
              filename: bcFileName),
      "Is_first_standard": isFirstStandard,
      "gender": gender,
      // "email": email,
      "tc_number": tcNumber,
      "tc_file": tcFile == null
          ? null
          : await MultipartFile.fromFile(tcFile!.path, filename: tcFileName),
    }, ListFormat.multiCompatible);
    if (timeslotId?.isNotEmpty ?? false) {
      for (var i = 0; i < timeslotId!.length; i++) {
        data.fields.add(MapEntry('timeslot_id[$i]', timeslotId![i].toString()));
      }
    }
    return data;
  }
}
