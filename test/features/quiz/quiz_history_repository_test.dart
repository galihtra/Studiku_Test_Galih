import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/features/quiz/data/quiz_history_repository.dart';
import 'package:kalkumi/features/quiz/domain/question_answer.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('riwayat disimpan terbaru lebih dulu dan bisa dibaca ulang', () async {
    final repository = SharedPreferencesQuizHistoryRepository();
    final older = _entry('older', DateTime(2026, 1, 1), score: 4);
    final newer = _entry(
      'newer',
      DateTime(2026, 1, 2),
      score: 8,
      answers: const [
        QuestionAnswer(
          questionPrompt: '2 + 3 = ?',
          options: ['4', '5', '6', '7'],
          correctAnswer: '5',
          userAnswer: '5',
        ),
      ],
    );

    await repository.add(older);
    await repository.add(newer);
    final history = await repository.getAll();

    expect(history.map((entry) => entry.id), ['newer', 'older']);
    expect(history.first.score, 8);
    expect(history.first.answers.single.isCorrect, isTrue);
  });

  test('retry untuk id yang sama mengganti data tanpa duplikasi', () async {
    final repository = SharedPreferencesQuizHistoryRepository();
    final timestamp = DateTime(2026, 1, 1);

    await repository.add(_entry('same-id', timestamp, score: 4));
    await repository.add(_entry('same-id', timestamp, score: 9));
    final history = await repository.getAll();

    expect(history, hasLength(1));
    expect(history.single.score, 9);
  });

  test(
    'jumlah riwayat dibatasi agar storage tidak tumbuh tanpa batas',
    () async {
      final repository = SharedPreferencesQuizHistoryRepository();
      for (var index = 0; index < AppValues.maxHistoryEntries + 3; index++) {
        await repository.add(
          _entry('id-$index', DateTime(2026, 1, 1).add(Duration(days: index))),
        );
      }

      final history = await repository.getAll();
      expect(history, hasLength(AppValues.maxHistoryEntries));
      expect(history.first.id, 'id-${AppValues.maxHistoryEntries + 2}');
    },
  );

  test(
    'data JSON rusak dilaporkan sebagai failure yang dapat ditangani UI',
    () {
      SharedPreferences.setMockInitialValues({
        AppValues.historyStorageKey: jsonEncode([
          {'id': 'broken'},
        ]),
      });

      expect(
        SharedPreferencesQuizHistoryRepository().getAll,
        throwsFormatException,
      );
    },
  );
}

QuizHistoryEntry _entry(
  String id,
  DateTime completedAt, {
  int score = 7,
  List<QuestionAnswer>? answers,
}) => QuizHistoryEntry(
  id: id,
  difficulty: QuizDifficulty.medium,
  score: score,
  totalQuestions: AppValues.questionsPerSession,
  bestScore: score,
  isNewBest: true,
  completedAt: completedAt,
  answers: answers,
);
