class ExamSubmitModel {
  String? examId;
  String? status;
  String? timeTaken;
  List<Question>? questions;

  ExamSubmitModel({
    this.examId,
    this.status,
    this.timeTaken,
    this.questions,
  });

  factory ExamSubmitModel.fromJson(Map<String, dynamic> json) =>
      ExamSubmitModel(
        examId: json["exam_id"],
        status: json["status"],
        timeTaken: json["time_taken"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exam_id": examId,
        "status": status,
        "time_taken": timeTaken,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  int? questionId;
  int? optionId;

  Question({
    this.questionId,
    this.optionId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["questionId"],
        optionId: json["optionId"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "optionId": optionId,
      };
}
