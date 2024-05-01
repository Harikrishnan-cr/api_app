class FaqModel {
  final String question;
  final String answer;

  const FaqModel({
    required this.question,
    required this.answer,
  });

  @override
  String toString() {
    return 'Datum( question: $question, answer: $answer)';
  }

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        question: json['question'] as String? ?? '',
        answer: json['answer'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
      };
}
