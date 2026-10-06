import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/features/quiz/data/question_generator.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';

void main() {
  const generator = QuestionGenerator();

  for (final difficulty in QuizDifficulty.values) {
    test('menghasilkan 10 soal valid dan unik untuk ${difficulty.name}', () {
      final questions = generator.generate(difficulty, random: Random(42));

      expect(questions, hasLength(10));
      expect(questions.map((question) => question.id).toSet(), hasLength(10));

      for (final question in questions) {
        expect(question.options, hasLength(4));
        expect(question.options.toSet(), hasLength(4));
        expect(question.options, contains(question.correctAnswer));
      }
    });
  }

  test('menolak jumlah soal di luar batas sesi', () {
    expect(
      () => generator.generate(QuizDifficulty.easy, count: 99),
      throwsArgumentError,
    );
  });

  test('easy hanya menghasilkan tambah atau kurang tanpa hasil negatif', () {
    final questions = generator.generate(
      QuizDifficulty.easy,
      count: 30,
      random: Random(11),
    );

    for (final question in questions) {
      expect(question.prompt, matches(RegExp(r'^\d+ [+-] \d+ = \?$')));
      expect(int.parse(question.correctAnswer), greaterThanOrEqualTo(0));
    }
  });

  test('medium dapat menghasilkan operasi perkalian', () {
    final questions = generator.generate(
      QuizDifficulty.medium,
      count: 30,
      random: Random(42),
    );

    expect(questions.any((question) => question.prompt.contains('×')), isTrue);
  });

  test('hard menggunakan ekspresi dua langkah dan pembagian selalu eksak', () {
    final questions = generator.generate(
      QuizDifficulty.hard,
      count: 30,
      random: Random(8),
    );

    expect(
      questions.every((question) => question.prompt.startsWith('(')),
      isTrue,
    );
    expect(
      questions.every((question) => question.prompt.contains(')')),
      isTrue,
    );
    expect(questions.any((question) => question.prompt.contains('÷')), isTrue);
    expect(
      questions.every(
        (question) => int.tryParse(question.correctAnswer) != null,
      ),
      isTrue,
    );
  });
}
