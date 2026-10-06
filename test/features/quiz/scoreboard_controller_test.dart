import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';

class _ControllableScoreRepository implements BestScoreRepository {
  _ControllableScoreRepository({this.shouldFail = false});

  bool shouldFail;
  final Map<QuizDifficulty, int> scores = {
    for (final difficulty in QuizDifficulty.values) difficulty: 0,
  };

  void _checkFailure() {
    if (shouldFail) throw StateError('Simulated storage failure');
  }

  @override
  Future<Map<QuizDifficulty, int>> getAll() async {
    _checkFailure();
    return Map.of(scores);
  }

  @override
  Future<int> getBest(QuizDifficulty difficulty) async {
    _checkFailure();
    return scores[difficulty] ?? 0;
  }

  @override
  Future<ScoreUpdate> saveIfHigher(QuizDifficulty difficulty, int score) async {
    _checkFailure();
    final previous = scores[difficulty] ?? 0;
    final isNewBest = score > previous;
    if (isNewBest) scores[difficulty] = score;
    return ScoreUpdate(
      bestScore: scores[difficulty] ?? 0,
      isNewBest: isNewBest,
    );
  }
}

void main() {
  test('load sukses mengekspos skor melalui provider controller', () async {
    final repository = _ControllableScoreRepository();
    repository.scores[QuizDifficulty.easy] = 7;
    final controller = ScoreboardController(repository);
    addTearDown(controller.dispose);

    await controller.load();

    expect(controller.status, ScoreboardStatus.success);
    expect(controller.bestOverall, 7);
    expect(controller.bestFor(QuizDifficulty.easy), 7);
  });

  test(
    'storage failure menjadi recoverable error dan dapat dicoba ulang',
    () async {
      final repository = _ControllableScoreRepository(shouldFail: true);
      final controller = ScoreboardController(repository);
      addTearDown(controller.dispose);

      await controller.load();
      expect(controller.status, ScoreboardStatus.failure);
      expect(controller.errorMessage, isNotEmpty);

      repository.shouldFail = false;
      repository.scores[QuizDifficulty.medium] = 6;
      await controller.load();

      expect(controller.status, ScoreboardStatus.success);
      expect(controller.bestFor(QuizDifficulty.medium), 6);
    },
  );

  test('save failure diteruskan agar UI dapat menawarkan retry', () async {
    final repository = _ControllableScoreRepository(shouldFail: true);
    final controller = ScoreboardController(repository);
    addTearDown(controller.dispose);

    expect(
      () => controller.saveScore(QuizDifficulty.hard, 8),
      throwsStateError,
    );
  });
}
