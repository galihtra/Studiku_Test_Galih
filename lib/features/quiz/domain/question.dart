import 'dart:math';

class Question {
  const Question({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctAnswer,
  });

  final String id;
  final String prompt;
  final List<String> options;
  final String correctAnswer;

  bool isCorrect(String answer) => answer == correctAnswer;

  Question shuffled(Random random) {
    final shuffledOptions = List<String>.of(options)..shuffle(random);
    return Question(
      id: id,
      prompt: prompt,
      options: List.unmodifiable(shuffledOptions),
      correctAnswer: correctAnswer,
    );
  }
}
