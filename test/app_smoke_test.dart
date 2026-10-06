import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/app.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/data/quiz_history_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';

class _FakeScoreRepository implements BestScoreRepository {
  final Map<QuizDifficulty, int> _scores = {
    for (final difficulty in QuizDifficulty.values) difficulty: 0,
  };

  @override
  Future<Map<QuizDifficulty, int>> getAll() async => Map.of(_scores);

  @override
  Future<int> getBest(QuizDifficulty difficulty) async =>
      _scores[difficulty] ?? 0;

  @override
  Future<ScoreUpdate> saveIfHigher(QuizDifficulty difficulty, int score) async {
    final previous = _scores[difficulty] ?? 0;
    final isNewBest = score > previous;
    if (isNewBest) _scores[difficulty] = score;
    return ScoreUpdate(
      bestScore: _scores[difficulty] ?? 0,
      isNewBest: isNewBest,
    );
  }
}

class _FailingScoreRepository implements BestScoreRepository {
  @override
  Future<Map<QuizDifficulty, int>> getAll() async {
    throw StateError('Simulated read failure');
  }

  @override
  Future<int> getBest(QuizDifficulty difficulty) async {
    throw StateError('Simulated read failure');
  }

  @override
  Future<ScoreUpdate> saveIfHigher(QuizDifficulty difficulty, int score) async {
    throw StateError('Simulated write failure');
  }
}

class _FakeHistoryRepository implements QuizHistoryRepository {
  _FakeHistoryRepository([List<QuizHistoryEntry> entries = const []])
    : _entries = List.of(entries);

  List<QuizHistoryEntry> _entries;

  @override
  Future<List<QuizHistoryEntry>> add(QuizHistoryEntry entry) async {
    _entries = [entry, ..._entries.where((item) => item.id != entry.id)];
    return List.unmodifiable(_entries);
  }

  @override
  Future<List<QuizHistoryEntry>> getAll() async => List.unmodifiable(_entries);
}

void main() {
  testWidgets('splash berpindah ke home', (tester) async {
    await tester.pumpWidget(
      KalkumiApp(
        scoreRepository: _FakeScoreRepository(),
        historyRepository: _FakeHistoryRepository(),
      ),
    );

    expect(find.byKey(const Key('splash_logo')), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Siap jadi\njagoan matematika?'), findsOneWidget);
  });

  testWidgets('home membuka pemilihan tingkat kesulitan', (tester) async {
    await tester.pumpWidget(
      KalkumiApp(
        scoreRepository: _FakeScoreRepository(),
        historyRepository: _FakeHistoryRepository(),
        initialLocation: AppRoutes.home,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Siap jadi\njagoan matematika?'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('start_quiz_button')));
    await tester.tap(find.byKey(const Key('start_quiz_button')));
    await tester.pumpAndSettle();

    expect(find.text('Pilih kekuatanmu'), findsOneWidget);
    expect(find.byKey(const Key('difficulty_easy')), findsOneWidget);
    expect(find.byKey(const Key('difficulty_medium')), findsOneWidget);
    expect(find.byKey(const Key('difficulty_hard')), findsOneWidget);
  });

  testWidgets('gagal membaca skor menampilkan retry tanpa memblokir quiz', (
    tester,
  ) async {
    await tester.pumpWidget(
      KalkumiApp(
        scoreRepository: _FailingScoreRepository(),
        historyRepository: _FakeHistoryRepository(),
        initialLocation: AppRoutes.home,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Data skor tidak tampil'), findsOneWidget);
    expect(find.text('Coba lagi'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(find.byKey(const Key('start_quiz_button')));
    await tester.tap(find.byKey(const Key('start_quiz_button')));
    await tester.pumpAndSettle();

    expect(find.text('Pilih kekuatanmu'), findsOneWidget);
    expect(find.byKey(const Key('difficulty_easy')), findsOneWidget);
  });

  testWidgets('menyelesaikan 10 soal menampilkan halaman hasil', (
    tester,
  ) async {
    await tester.pumpWidget(
      KalkumiApp(
        scoreRepository: _FakeScoreRepository(),
        historyRepository: _FakeHistoryRepository(),
        initialLocation: AppRoutes.home,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('start_quiz_button')));
    await tester.tap(find.byKey(const Key('start_quiz_button')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('difficulty_easy')));
    await tester.tap(find.byKey(const Key('difficulty_easy')));
    await tester.pumpAndSettle();

    for (var index = 0; index < 10; index++) {
      await tester.tap(find.byKey(const Key('answer_0')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('next_question_button')));
      await tester.pumpAndSettle();
    }

    expect(find.byKey(const Key('result_score')), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(find.text('Main Lagi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('riwayat dari home membuka detail hasil yang tepat', (
    tester,
  ) async {
    final entry = QuizHistoryEntry(
      id: 'session-1',
      difficulty: QuizDifficulty.medium,
      score: 8,
      totalQuestions: 10,
      bestScore: 8,
      isNewBest: true,
      completedAt: DateTime(2026, 10, 6, 9, 30),
    );
    await tester.pumpWidget(
      KalkumiApp(
        scoreRepository: _FakeScoreRepository(),
        historyRepository: _FakeHistoryRepository([entry]),
        initialLocation: AppRoutes.home,
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull, reason: 'home history layout');

    final historyTile = find.byKey(const Key('history_session-1'));
    await tester.ensureVisible(historyTile);
    await tester.tap(historyTile);
    await tester.pumpAndSettle();

    expect(find.text('Detail Hasil'), findsOneWidget);
    expect(find.byKey(const Key('history_result_score')), findsOneWidget);
    expect(find.text('8/10'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pagination history menampilkan sesi berikutnya', (tester) async {
    final entries = List.generate(
      5,
      (index) => QuizHistoryEntry(
        id: 'session-${index + 1}',
        difficulty: QuizDifficulty.easy,
        score: index,
        totalQuestions: 10,
        bestScore: index,
        isNewBest: false,
        completedAt: DateTime(2026, 10, 7, 10, index),
      ),
    );
    await tester.pumpWidget(
      KalkumiApp(
        scoreRepository: _FakeScoreRepository(),
        historyRepository: _FakeHistoryRepository(entries),
        initialLocation: AppRoutes.home,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('history_session-1')), findsOneWidget);
    expect(find.byKey(const Key('history_session-5')), findsNothing);

    final nextPage = find.byKey(const Key('history_next_page'));
    await tester.ensureVisible(nextPage);
    await tester.tap(nextPage);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('history_session-1')), findsNothing);
    expect(find.byKey(const Key('history_session-5')), findsOneWidget);
  });
}
