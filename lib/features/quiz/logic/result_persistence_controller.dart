import 'package:flutter/foundation.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';

class ResultPersistenceController extends ChangeNotifier {
  ResultPersistenceController({
    required this.entry,
    required this.scoreboard,
    required this.history,
    required bool persistenceFailed,
  }) : _persistenceFailed = persistenceFailed,
       _bestScore = entry.bestScore,
       _isNewBest = entry.isNewBest;

  final QuizHistoryEntry entry;
  final ScoreboardController scoreboard;
  final QuizHistoryController history;

  bool _persistenceFailed;
  bool _retrying = false;
  int _bestScore;
  bool _isNewBest;

  bool get persistenceFailed => _persistenceFailed;
  bool get retrying => _retrying;
  int get bestScore => _bestScore;
  bool get isNewBest => _isNewBest;

  Future<void> retry() async {
    if (_retrying) return;
    _retrying = true;
    notifyListeners();

    var failed = false;
    try {
      final update = await scoreboard.saveScore(entry.difficulty, entry.score);
      _bestScore = update.bestScore;
      _isNewBest = _isNewBest || update.isNewBest;
    } catch (_) {
      failed = true;
    }

    try {
      await history.add(
        QuizHistoryEntry(
          id: entry.id,
          difficulty: entry.difficulty,
          score: entry.score,
          totalQuestions: entry.totalQuestions,
          bestScore: _bestScore,
          isNewBest: _isNewBest,
          completedAt: entry.completedAt,
          answers: entry.answers,
        ),
      );
    } catch (_) {
      failed = true;
    }

    _persistenceFailed = failed;
    _retrying = false;
    notifyListeners();
  }
}
