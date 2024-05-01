class FeePaymentJsonModel {
    bool? status;
    FeePaymentModel? data;
    String? message;

    FeePaymentJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory FeePaymentJsonModel.fromJson(Map<String, dynamic> json) => FeePaymentJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : FeePaymentModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class FeePaymentModel {
    List<dynamic>? coursePayments;
    dynamic payments;

    FeePaymentModel({
        this.coursePayments,
        this.payments,
    });

    factory FeePaymentModel.fromJson(Map<String, dynamic> json) => FeePaymentModel(
        coursePayments: json["coursePayments"] == null ? [] : List<dynamic>.from(json["coursePayments"]!.map((x) => x)),
        payments: json["payments"],
    );

    Map<String, dynamic> toJson() => {
        "coursePayments": coursePayments == null ? [] : List<dynamic>.from(coursePayments!.map((x) => x)),
        "payments": payments,
    };
}
