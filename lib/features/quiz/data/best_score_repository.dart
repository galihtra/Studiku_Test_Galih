import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreUpdate {
  const ScoreUpdate({required this.bestScore, required this.isNewBest});

  final int bestScore;
  final bool isNewBest;
}

abstract interface class BestScoreRepository {
  Future<int> getBest(QuizDifficulty difficulty);

  Future<Map<QuizDifficulty, int>> getAll();

  Future<ScoreUpdate> saveIfHigher(QuizDifficulty difficulty, int score);
}

class SharedPreferencesBestScoreRepository implements BestScoreRepository {
  @override
  Future<int> getBest(QuizDifficulty difficulty) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(difficulty.storageKey) ?? 0;
  }

  @override
  Future<Map<QuizDifficulty, int>> getAll() async {
    final preferences = await SharedPreferences.getInstance();
    return {
      for (final difficulty in QuizDifficulty.values)
        difficulty: preferences.getInt(difficulty.storageKey) ?? 0,
    };
  }

  @override
  Future<ScoreUpdate> saveIfHigher(QuizDifficulty difficulty, int score) async {
    if (score < 0 || score > AppValues.questionsPerSession) {
      throw ArgumentError.value(
        score,
        'score',
        'Skor harus 0 sampai ${AppValues.questionsPerSession}.',
      );
    }

    final preferences = await SharedPreferences.getInstance();
    final previous = preferences.getInt(difficulty.storageKey) ?? 0;
    if (score <= previous) {
      return ScoreUpdate(bestScore: previous, isNewBest: false);
    }

    await preferences.setInt(difficulty.storageKey, score);
    return ScoreUpdate(bestScore: score, isNewBest: true);
  }
}
