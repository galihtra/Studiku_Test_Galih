import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/data/quiz_history_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/logic/result_persistence_controller.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/resources/values_app.dart';

class _ScoreRepository implements BestScoreRepository {
  _ScoreRepository({this.score = 0, this.shouldFail = false});

  int score;
  bool shouldFail;

  @override
  Future<Map<QuizDifficulty, int>> getAll() async => {
    for (final difficulty in QuizDifficulty.values) difficulty: score,
  };

  @override
  Future<int> getBest(QuizDifficulty difficulty) async => score;

  @override
  Future<ScoreUpdate> saveIfHigher(QuizDifficulty difficulty, int value) async {
    if (shouldFail) throw StateError('Simulated score failure');
    final isNewBest = value > score;
    if (isNewBest) score = value;
    return ScoreUpdate(bestScore: score, isNewBest: isNewBest);
  }
}

class _HistoryRepository implements QuizHistoryRepository {
  bool shouldFail = false;
  int addCalls = 0;
  QuizHistoryEntry? savedEntry;

  @override
  Future<List<QuizHistoryEntry>> add(QuizHistoryEntry entry) async {
    addCalls += 1;
    if (shouldFail) throw StateError('Simulated history failure');
    savedEntry = entry;
    return [entry];
  }

  @override
  Future<List<QuizHistoryEntry>> getAll() async => const [];
}

void main() {
  test('retry sukses menyimpan skor dan history', () async {
    final scoreRepository = _ScoreRepository();
    final historyRepository = _HistoryRepository();
    final scoreboard = ScoreboardController(scoreRepository);
    final history = QuizHistoryController(historyRepository);
    final controller = ResultPersistenceController(
      entry: _entry(isNewBest: false),
      scoreboard: scoreboard,
      history: history,
      persistenceFailed: true,
    );
    addTearDown(controller.dispose);
    addTearDown(scoreboard.dispose);
    addTearDown(history.dispose);

    await controller.retry();

    expect(controller.persistenceFailed, isFalse);
    expect(controller.bestScore, 8);
    expect(controller.isNewBest, isTrue);
    expect(historyRepository.savedEntry?.bestScore, 8);
  });

  test(
    'retry mempertahankan status rekor dan tetap mencoba kedua storage',
    () async {
      final scoreRepository = _ScoreRepository(score: 8, shouldFail: true);
      final historyRepository = _HistoryRepository();
      final scoreboard = ScoreboardController(scoreRepository);
      final history = QuizHistoryController(historyRepository);
      final controller = ResultPersistenceController(
        entry: _entry(isNewBest: true),
        scoreboard: scoreboard,
        history: history,
        persistenceFailed: true,
      );
      addTearDown(controller.dispose);
      addTearDown(scoreboard.dispose);
      addTearDown(history.dispose);

      await controller.retry();

      expect(controller.persistenceFailed, isTrue);
      expect(controller.isNewBest, isTrue);
      expect(historyRepository.addCalls, 1);
      expect(historyRepository.savedEntry?.isNewBest, isTrue);
    },
  );
}

QuizHistoryEntry _entry({required bool isNewBest}) => QuizHistoryEntry(
  id: 'result-1',
  difficulty: QuizDifficulty.medium,
  score: 8,
  totalQuestions: AppValues.questionsPerSession,
  bestScore: 8,
  isNewBest: isNewBest,
  completedAt: DateTime(2026, 10, 7),
);
