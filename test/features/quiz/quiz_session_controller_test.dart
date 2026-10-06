import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/features/quiz/data/question_generator.dart';
import 'package:kalkumi/features/quiz/domain/question.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/logic/quiz_session_controller.dart';

class _FailingQuestionGenerator extends QuestionGenerator {
  const _FailingQuestionGenerator();

  @override
  List<Question> generate(
    QuizDifficulty difficulty, {
    int count = 10,
    Random? random,
  }) {
    throw StateError('Simulated question generator failure');
  }
}

void main() {
  test('jawaban benar menambah skor dan jawaban ganda diabaikan', () {
    final controller = QuizSessionController(
      difficulty: QuizDifficulty.easy,
      random: Random(1),
    );
    addTearDown(controller.dispose);

    final question = controller.currentQuestion;
    controller.answer(question.correctAnswer);
    controller.answer(question.correctAnswer);

    expect(controller.score, 1);
    expect(controller.hasAnswered, isTrue);
    expect(controller.selectedAnswerIsCorrect, isTrue);
    expect(controller.answers, hasLength(1));
    expect(controller.answers.single.questionPrompt, question.prompt);
    expect(controller.answers.single.userAnswer, question.correctAnswer);
  });

  test('sesi selesai setelah 10 soal dan menghitung skor tepat', () {
    final controller = QuizSessionController(
      difficulty: QuizDifficulty.medium,
      random: Random(7),
    );
    addTearDown(controller.dispose);

    for (var index = 0; index < controller.totalQuestions; index++) {
      final question = controller.currentQuestion;
      final answer = index.isEven
          ? question.correctAnswer
          : question.options.firstWhere(
              (option) => option != question.correctAnswer,
            );
      controller.answer(answer);
      controller.advance();
    }

    expect(controller.isComplete, isTrue);
    expect(controller.score, 5);
    expect(controller.progress, 1);
  });

  test('menampilkan error state ketika data soal gagal dibuat', () {
    final controller = QuizSessionController(
      difficulty: QuizDifficulty.hard,
      generator: const _FailingQuestionGenerator(),
    );
    addTearDown(controller.dispose);

    expect(controller.hasLoadError, isTrue);
    expect(controller.totalQuestions, 0);
    expect(controller.progress, 0);
    expect(controller.loadError, isNotEmpty);
  });
}
