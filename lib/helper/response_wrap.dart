import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseWrap<Type> {
  final int status;
  final String message;
  final Type? data;
  ResponseWrap({
    required this.status,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data,
    };
  }

  factory ResponseWrap.fromMap(Map<String, dynamic> map, data) {
    return ResponseWrap<Type>(
      status: map['status'] as int,
      message: map['message'] as String,
      data: data,
    );
  }

  String toJson() => json.encode(toMap());

}
