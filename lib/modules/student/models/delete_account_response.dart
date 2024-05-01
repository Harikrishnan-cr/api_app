class DeleteAccountResponse {
  bool? status;
  int? errorCode;
  String? message;
  bool? response;

  DeleteAccountResponse({
    this.status,
    this.errorCode,
    this.message,
    this.response,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAccountResponse(
        status: json["status"],
        errorCode: json["errorCode"],
        message: json["message"],
        response: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "message": message,
        "response": response,
      };
}
