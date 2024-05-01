class MCQMarkModel {
    int? studentId;
    ExamDetails? examDetails;

    MCQMarkModel({
        this.studentId,
        this.examDetails,
    });

    factory MCQMarkModel.fromJson(Map<String, dynamic> json) => MCQMarkModel(
        studentId: json["studentId"],
        examDetails: json["examDetails"] == null ? null : ExamDetails.fromJson(json["examDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "examDetails": examDetails?.toJson(),
    };
}

class ExamDetails {
    int? studentId;
    String? studentName;
    int? mark;
    int? totalMark;
    String? status;
    int? correctAnswers;
    int? wrongAnswers;
    int? passMark;
    String? message;

    ExamDetails({
        this.studentId,
        this.studentName,
        this.mark,
        this.totalMark,
        this.status,
        this.correctAnswers,
        this.wrongAnswers,
        this.passMark,
        this.message,
    });

    factory ExamDetails.fromJson(Map<String, dynamic> json) => ExamDetails(
        studentId: json["studentId"],
        studentName: json["studentName"],
        mark: json["mark"],
        totalMark: json["totalMark"],
        status: json["status"],
        correctAnswers: json["correctAnswers"],
        wrongAnswers: json["wrongAnswers"],
        passMark: json["passMark"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "studentName": studentName,
        "mark": mark,
        "totalMark": totalMark,
        "status": status,
        "correctAnswers": correctAnswers,
        "wrongAnswers": wrongAnswers,
        "passMark": passMark,
        "message": message,
    };
}
