class PasswordResetModel {
    bool? status;
    String? data;
    String? message;

    PasswordResetModel({
        this.status,
        this.data,
        this.message,
    });

    factory PasswordResetModel.fromJson(Map<String, dynamic> json) => PasswordResetModel(
        status: json["status"],
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
    };
}
