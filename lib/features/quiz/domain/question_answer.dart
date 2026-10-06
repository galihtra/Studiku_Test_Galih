class QuestionAnswer {
  const QuestionAnswer({
    required this.questionPrompt,
    required this.options,
    required this.correctAnswer,
    required this.userAnswer,
  });

  final String questionPrompt;
  final List<String> options;
  final String correctAnswer;
  final String? userAnswer;

  bool get isCorrect => userAnswer == correctAnswer;
  bool get isAnswered => userAnswer != null;

  Map<String, Object> toJson() => {
    'questionPrompt': questionPrompt,
    'options': options,
    'correctAnswer': correctAnswer,
    'userAnswer': userAnswer ?? '',
  };

  factory QuestionAnswer.fromJson(Map<String, Object?> json) {
    final options = json['options'];
    final userAnswerRaw = json['userAnswer'] as String?;
    return QuestionAnswer(
      questionPrompt: json['questionPrompt'] as String? ?? '',
      options: options is List ? options.map((e) => e.toString()).toList() : [],
      correctAnswer: json['correctAnswer'] as String? ?? '',
      userAnswer: userAnswerRaw?.isNotEmpty == true ? userAnswerRaw : null,
    );
  }
}
