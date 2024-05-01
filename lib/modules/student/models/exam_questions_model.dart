class ExamsQuestionsJsonModel {
  bool? status;
  ExamQuestionsData? data;
  String? message;

  ExamsQuestionsJsonModel({
    this.status,
    this.data,
    this.message,
  });

  factory ExamsQuestionsJsonModel.fromJson(Map<String, dynamic> json) =>
      ExamsQuestionsJsonModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : ExamQuestionsData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class ExamQuestionsData {
  int? countOfQuestions;
  List<ExamQuestion>? examQuestions;
  ExamPool? examPool;

  late int studentId;
  late int examId;

  String status = 'completed';

  int timeTaken = 0;

  ExamQuestionsData({
    this.countOfQuestions,
    this.examQuestions,
    this.examPool,
  });

  factory ExamQuestionsData.fromJson(Map<String, dynamic> json) =>
      ExamQuestionsData(
        countOfQuestions: json["countOfQuestions"],
        examQuestions: json["examQuestions"] == null
            ? []
            : List<ExamQuestion>.from(
                json["examQuestions"]!.map((x) => ExamQuestion.fromJson(x))),
        examPool: json["examPool"] == null
            ? null
            : ExamPool.fromJson(json["examPool"]),
      );

  Map<String, dynamic> toJson() => {
        "countOfQuestions": countOfQuestions,
        "examQuestions": examQuestions == null
            ? []
            : List<dynamic>.from(examQuestions!.map((x) => x.toJson())),
        "examPool": examPool?.toJson(),
      };

  Map<String, dynamic> toSubmitJson(ExamQuestionsData? examModel, int examId) =>
      {
        "exam_id": examId,
        "status": "completed",
        "time_taken": examModel?.timeTaken,
        "questions": List<dynamic>.from(
          List.generate(
              examModel?.examQuestions?.length ?? 0,
              (index) => Question(
                  questionType: examModel?.examQuestions?[index].examType,
                  optionId: examModel?.examQuestions?[index].selectedAnswer?.id,
                  questionId: examModel?.examQuestions?[index].id)).map(
              (x) => x.toJson()),
        )
      };
}

class ExamPool {
  int? id;
  String? examDisplayId;
  String? examMode;
  int? passMark;
  int? durationInMin;
  int? fkClassId;
  int? isActive;
  int? fkExamId;
  String? encodedId;

  ExamPool({
    this.id,
    this.examDisplayId,
    this.examMode,
    this.passMark,
    this.durationInMin,
    this.fkClassId,
    this.isActive,
    this.fkExamId,
    this.encodedId,
  });

  factory ExamPool.fromJson(Map<String, dynamic> json) => ExamPool(
        id: json["id"],
        examDisplayId: json["examDisplayId"],
        examMode: json["examMode"],
        passMark: json["passMark"],
        durationInMin: json["durationInMin"],
        fkClassId: json["fkClassId"],
        isActive: json["isActive"],
        fkExamId: json["fkExamId"],
        encodedId: json["encodedId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "examDisplayId": examDisplayId,
        "examMode": examMode,
        "passMark": passMark,
        "durationInMin": durationInMin,
        "fkClassId": fkClassId,
        "isActive": isActive,
        "fkExamId": fkExamId,
        "encodedId": encodedId,
      };
}

class ExamQuestion {
  String? question;
  int? id;
  int? marks;
  List<dynamic>? images;
  int? isActive;
  int? noOfOptions;
  String? examType;
  String? answerType;
  String? examQuestionDisplayId;
  List<Option>? options;
  List<dynamic>? media;
  Option? selectedAnswer;
  String? subjectiveAnswer;
  bool isViewSolution = false;

  ExamQuestion({
    this.question,
    this.id,
    this.marks,
    this.images,
    this.isActive,
    this.noOfOptions,
    this.examType,
    this.answerType,
    this.examQuestionDisplayId,
    this.options,
    this.media,
  });

  factory ExamQuestion.fromJson(Map<String, dynamic> json) => ExamQuestion(
        question: json["question"],
        id: json["id"],
        marks: json["marks"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        isActive: json["isActive"],
        noOfOptions: json["noOfOptions"],
        examType: json["examType"],
        answerType: json["answerType"],
        examQuestionDisplayId: json["examQuestionDisplayId"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "id": id,
        "marks": marks,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "isActive": isActive,
        "noOfOptions": noOfOptions,
        "examType": examType,
        "answerType": answerType,
        "examQuestionDisplayId": examQuestionDisplayId,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
      };
}

class Option {
  int? id;
  String? optionName;
  dynamic optionDescription;
  dynamic optionImages;
  int? fkExamQuestionId;
  int? isCorrect;
  DateTime? createdAt;
  DateTime? updatedAt;

  Option({
    this.id,
    this.optionName,
    this.optionDescription,
    this.optionImages,
    this.fkExamQuestionId,
    this.isCorrect,
    this.createdAt,
    this.updatedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        optionName: json["optionName"],
        optionDescription: json["optionDescription"],
        optionImages: json["optionImages"],
        fkExamQuestionId: json["fkExamQuestionId"],
        isCorrect: json["isCorrect"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "optionName": optionName,
        "optionDescription": optionDescription,
        "optionImages": optionImages,
        "fkExamQuestionId": fkExamQuestionId,
        "isCorrect": isCorrect,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ExamsResultModel {
  String? examId;
  String? status;
  String? timeTaken;
  List<Question>? questions;

  ExamsResultModel({
    this.examId,
    this.status,
    this.timeTaken,
    this.questions,
  });

  factory ExamsResultModel.fromJson(Map<String, dynamic> json) =>
      ExamsResultModel(
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
  String? questionType;

  Question({this.questionId, this.optionId, this.questionType});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      questionId: json["questionId"],
      optionId: json["optionId"],
      questionType: json["question_type"]);

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "optionId": optionId,
        "question_type": questionType
      };
}
