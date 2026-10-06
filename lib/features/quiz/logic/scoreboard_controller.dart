import 'package:flutter/foundation.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';

enum ScoreboardStatus { initial, loading, success, failure }

class ScoreboardController extends ChangeNotifier {
  ScoreboardController(this._repository);

  final BestScoreRepository _repository;

  ScoreboardStatus _status = ScoreboardStatus.initial;
  Map<QuizDifficulty, int> _scores = {
    for (final difficulty in QuizDifficulty.values) difficulty: 0,
  };
  String? _errorMessage;

  ScoreboardStatus get status => _status;
  Map<QuizDifficulty, int> get scores => Map.unmodifiable(_scores);
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == ScoreboardStatus.loading;
  bool get hasError => _status == ScoreboardStatus.failure;

  int bestFor(QuizDifficulty difficulty) => _scores[difficulty] ?? 0;

  int get bestOverall => _scores.values.fold(0, (best, score) {
    return score > best ? score : best;
  });

  int get playedLevels => _scores.values.where((score) => score > 0).length;

  Future<void> load() async {
    if (_status == ScoreboardStatus.loading) return;

    _status = ScoreboardStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _scores = await _repository.getAll();
      _status = ScoreboardStatus.success;
    } catch (error) {
      if (kDebugMode) debugPrint('Gagal memuat best score: $error');
      _status = ScoreboardStatus.failure;
      _errorMessage = 'Best score belum dapat dimuat dari penyimpanan lokal.';
    }
    notifyListeners();
  }

  Future<ScoreUpdate> saveScore(QuizDifficulty difficulty, int score) async {
    try {
      final update = await _repository.saveIfHigher(difficulty, score);
      _scores = {..._scores, difficulty: update.bestScore};
      _status = ScoreboardStatus.success;
      _errorMessage = null;
      notifyListeners();
      return update;
    } catch (error) {
      if (kDebugMode) debugPrint('Gagal menyimpan best score: $error');
      rethrow;
    }
  }
}
