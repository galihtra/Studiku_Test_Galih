import 'dart:math';

import 'package:kalkumi/features/quiz/domain/question.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/resources/values_app.dart';

class QuestionGenerator {
  const QuestionGenerator();

  static const int maxQuestionsPerSession = 30;

  List<Question> generate(
    QuizDifficulty difficulty, {
    int count = AppValues.questionsPerSession,
    Random? random,
  }) {
    if (count < 1 || count > maxQuestionsPerSession) {
      throw ArgumentError.value(
        count,
        'count',
        'Harus di antara 1 dan $maxQuestionsPerSession.',
      );
    }

    final randomizer = random ?? Random();
    final questions = <Question>[];
    final prompts = <String>{};
    final maxAttempts = count * 50;

    for (
      var attempt = 0;
      questions.length < count && attempt < maxAttempts;
      attempt++
    ) {
      final draft = _createDraft(difficulty, randomizer);
      if (!prompts.add(draft.prompt)) continue;

      final options = _buildOptions(draft.answer, randomizer);
      questions.add(
        Question(
          id: '${difficulty.name}_${questions.length}_${draft.prompt.hashCode.abs()}',
          prompt: draft.prompt,
          options: options.map((value) => '$value').toList(growable: false),
          correctAnswer: '${draft.answer}',
        ).shuffled(randomizer),
      );
    }

    if (questions.length != count) {
      throw StateError('Tidak dapat membuat $count soal unik yang valid.');
    }

    questions.shuffle(randomizer);
    return List.unmodifiable(questions);
  }

  _QuestionDraft _createDraft(QuizDifficulty difficulty, Random random) {
    return switch (difficulty) {
      QuizDifficulty.easy => _createEasy(random),
      QuizDifficulty.medium => _createMedium(random),
      QuizDifficulty.hard => _createHard(random),
    };
  }

  _QuestionDraft _createEasy(Random random) {
    final addition = random.nextBool();
    var first = random.nextInt(21);
    var second = random.nextInt(21);
    if (!addition && second > first) {
      final temporary = first;
      first = second;
      second = temporary;
    }
    return _QuestionDraft(
      '$first ${addition ? '+' : '-'} $second = ?',
      addition ? first + second : first - second,
    );
  }

  _QuestionDraft _createMedium(Random random) {
    final operation = random.nextInt(3);
    if (operation == 2) {
      final first = random.nextInt(11) + 2;
      final second = random.nextInt(11) + 2;
      return _QuestionDraft('$first × $second = ?', first * second);
    }

    var first = random.nextInt(101);
    var second = random.nextInt(101);
    if (operation == 1 && second > first) {
      final temporary = first;
      first = second;
      second = temporary;
    }
    return _QuestionDraft(
      '$first ${operation == 0 ? '+' : '-'} $second = ?',
      operation == 0 ? first + second : first - second,
    );
  }

  _QuestionDraft _createHard(Random random) {
    switch (random.nextInt(4)) {
      case 0:
        final first = random.nextInt(31) + 10;
        final second = random.nextInt(16) + 2;
        final multiplier = random.nextInt(8) + 2;
        return _QuestionDraft(
          '($first + $second) × $multiplier = ?',
          (first + second) * multiplier,
        );
      case 1:
        final first = random.nextInt(9) + 4;
        final second = random.nextInt(8) + 2;
        final subtractor = random.nextInt(first * second + 1);
        return _QuestionDraft(
          '($first × $second) - $subtractor = ?',
          (first * second) - subtractor,
        );
      case 2:
        final divisor = random.nextInt(8) + 2;
        final quotient = random.nextInt(15) + 2;
        final addend = random.nextInt(31);
        final dividend = divisor * quotient;
        return _QuestionDraft(
          '($dividend ÷ $divisor) + $addend = ?',
          quotient + addend,
        );
      default:
        final divisor = random.nextInt(8) + 2;
        final quotient = random.nextInt(15) + 2;
        final multiplier = random.nextInt(8) + 2;
        final dividend = divisor * quotient;
        return _QuestionDraft(
          '($dividend ÷ $divisor) × $multiplier = ?',
          quotient * multiplier,
        );
    }
  }

  List<int> _buildOptions(int answer, Random random) {
    final values = <int>{answer};
    const offsets = [1, -1, 2, -2, 3, -3, 5, -5, 10, -10];
    final shuffledOffsets = List<int>.of(offsets)..shuffle(random);

    for (final offset in shuffledOffsets) {
      final candidate = answer + offset;
      if (candidate >= 0) values.add(candidate);
      if (values.length == 4) break;
    }

    while (values.length < 4) {
      values.add(answer + random.nextInt(21) + 1);
    }

    return List<int>.of(values)..shuffle(random);
  }
}

class _QuestionDraft {
  const _QuestionDraft(this.prompt, this.answer);

  final String prompt;
  final int answer;
}
