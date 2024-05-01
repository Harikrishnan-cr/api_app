class QuizzSubmitModel {
    String? examId;
    String? status;
    String? timeTaken;
    List<QuizQuestion>? questions;

    QuizzSubmitModel({
        this.examId,
        this.status,
        this.timeTaken,
        this.questions,
    });

    factory QuizzSubmitModel.fromJson(Map<String, dynamic> json) => QuizzSubmitModel(
        examId: json["exam_id"],
        status: json["status"],
        timeTaken: json["time_taken"],
        questions: json["questions"] == null ? [] : List<QuizQuestion>.from(json["questions"]!.map((x) => QuizQuestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "exam_id": examId,
        "status": status,
        "time_taken": timeTaken,
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
    };
}

class QuizQuestion {
    int? questionId;
    int? optionId;

    QuizQuestion({
        this.questionId,
        this.optionId,
    });

    factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        questionId: json["questionId"],
        optionId: json["optionId"],
    );

    Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "optionId": optionId,
    };
}
