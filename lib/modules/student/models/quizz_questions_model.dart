import 'package:samastha/modules/student/models/quizz_submit_model.dart';

class QuizzQuestionsJsonModel {
    bool? status;
    QuizzQuestionsData? data;
    String? message;

    QuizzQuestionsJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory QuizzQuestionsJsonModel.fromJson(Map<String, dynamic> json) => QuizzQuestionsJsonModel(
        status: json["status"],
        data: json["data"] == null ? null : QuizzQuestionsData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class QuizzQuestionsData {
    int? countOfQuestions;
    List<QuizQuestionModel>? quizQuestions;
    QuizPool? quizPool;

    late int studentId;
  late int examId;

  String status = 'completed';

  int timeTaken = 0;

    QuizzQuestionsData({
        this.countOfQuestions,
        this.quizQuestions,
        this.quizPool,
    });

    factory QuizzQuestionsData.fromJson(Map<String, dynamic> json) => QuizzQuestionsData(
        countOfQuestions: json["countOfQuestions"],
        quizQuestions: json["quizQuestions"] == null ? [] : List<QuizQuestionModel>.from(json["quizQuestions"]!.map((x) => QuizQuestionModel.fromJson(x))),
        quizPool: json["quizPool"] == null ? null : QuizPool.fromJson(json["quizPool"]),
    );

    Map<String, dynamic> toJson() => {
        "countOfQuestions": countOfQuestions,
        "quizQuestions": quizQuestions == null ? [] : List<dynamic>.from(quizQuestions!.map((x) => x.toJson())),
        "quizPool": quizPool?.toJson(),
    };

    Map<String, dynamic> toSubmitJson(QuizzQuestionsData? examModel, int examId) =>
      {
        "exam_id": examId,
        "status": "completed",
        "time_taken": examModel?.timeTaken,
        "questions": List<dynamic>.from(
          List.generate(
              examModel?.quizQuestions?.length ?? 0,
              (index) => QuizQuestion(
                  optionId: examModel?.quizQuestions?[index].selectedAnswer?.id,
                  questionId: examModel?.quizQuestions?[index].id)).map(
              (x) => x.toJson()),
        )
      };
}

class QuizPool {
    int? id;
    String? examDisplayId;
    String? examMode;
    int? passMark;
    int? durationInMin;
    int? fkClassId;
    int? isActive;
    int? fkExamId;
    String? encodedId;

    QuizPool({
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

    factory QuizPool.fromJson(Map<String, dynamic> json) => QuizPool(
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

class QuizQuestionModel {
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

    QuizQuestionModel({
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

    factory QuizQuestionModel.fromJson(Map<String, dynamic> json) => QuizQuestionModel(
        question: json["question"],
        id: json["id"],
        marks: json["marks"],
        images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
        isActive: json["isActive"],
        noOfOptions: json["noOfOptions"],
        examType: json["examType"],
        answerType: json["answerType"],
        examQuestionDisplayId: json["examQuestionDisplayId"],
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
        media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "id": id,
        "marks": marks,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "isActive": isActive,
        "noOfOptions": noOfOptions,
        "examType": examType,
        "answerType": answerType,
        "examQuestionDisplayId": examQuestionDisplayId,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
    };
}

class Option {
    int? id;
    String? optionName;
    String? optionDescription;
    dynamic optionImages;
    int? fkExamQuestionId;
    int? isCorrect;
    int? createdBy;
    int? updatedBy;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Option({
        this.id,
        this.optionName,
        this.optionDescription,
        this.optionImages,
        this.fkExamQuestionId,
        this.isCorrect,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
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
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "optionName": optionName,
        "optionDescription": optionDescription,
        "optionImages": optionImages,
        "fkExamQuestionId": fkExamQuestionId,
        "isCorrect": isCorrect,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class QuizzResultJsonModel {
    bool? status;
    List<QuizResult>? data;
    String? message;

    QuizzResultJsonModel({
        this.status,
        this.data,
        this.message,
    });

    factory QuizzResultJsonModel.fromJson(Map<String, dynamic> json) => QuizzResultJsonModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<QuizResult>.from(json["data"]!.map((x) => QuizResult.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class QuizResult {
    int? studentId;
    String? studentName;
    int? mark;
    int? totalMark;
    String? status;
    int? correctAnswers;
    int? wrongAnswers;
    int? passMark;
    String? message;

    QuizResult({
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

    factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
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
