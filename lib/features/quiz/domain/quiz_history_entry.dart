import 'package:kalkumi/features/quiz/domain/question_answer.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/resources/values_app.dart';

class QuizHistoryEntry {
  const QuizHistoryEntry({
    required this.id,
    required this.difficulty,
    required this.score,
    required this.totalQuestions,
    required this.bestScore,
    required this.isNewBest,
    required this.completedAt,
    List<QuestionAnswer>? answers,
  }) : _answers = answers;

  final String id;
  final QuizDifficulty difficulty;
  final int score;
  final int totalQuestions;
  final int bestScore;
  final bool isNewBest;
  final DateTime completedAt;
  final List<QuestionAnswer>? _answers;

  List<QuestionAnswer> get answers => List.unmodifiable(_answers ?? const []);

  int get incorrectAnswers => totalQuestions - score;
  int get accuracy =>
      totalQuestions == 0 ? 0 : (score / totalQuestions * 100).round();

  factory QuizHistoryEntry.create({
    required QuizDifficulty difficulty,
    required int score,
    required int bestScore,
    required bool isNewBest,
    List<QuestionAnswer>? answers,
    DateTime? completedAt,
  }) {
    final timestamp = completedAt ?? DateTime.now();
    return QuizHistoryEntry(
      id: '${timestamp.microsecondsSinceEpoch}-${difficulty.name}',
      difficulty: difficulty,
      score: score,
      totalQuestions: AppValues.questionsPerSession,
      bestScore: bestScore,
      isNewBest: isNewBest,
      completedAt: timestamp,
      answers: answers,
    );
  }

  factory QuizHistoryEntry.fromJson(Map<String, Object?> json) {
    final difficultyName = json['difficulty'];
    final difficulty = QuizDifficulty.values
        .where((value) => value.name == difficultyName)
        .firstOrNull;
    final completedAt = DateTime.tryParse(json['completedAt'] as String? ?? '');
    final id = json['id'];
    final score = json['score'];
    final totalQuestions = json['totalQuestions'];
    final bestScore = json['bestScore'];
    final isNewBest = json['isNewBest'];
    final answersRaw = json['answers'];

    if (id is! String ||
        difficulty == null ||
        score is! int ||
        totalQuestions is! int ||
        bestScore is! int ||
        isNewBest is! bool ||
        completedAt == null ||
        totalQuestions <= 0 ||
        score < 0 ||
        score > totalQuestions) {
      throw const FormatException('Format riwayat quiz tidak valid.');
    }

    List<QuestionAnswer>? parsedAnswers;
    if (answersRaw is List) {
      parsedAnswers = answersRaw
          .map((item) {
            if (item is Map<String, Object?>) {
              return QuestionAnswer.fromJson(item);
            }
            return null;
          })
          .whereType<QuestionAnswer>()
          .toList();
    }

    return QuizHistoryEntry(
      id: id,
      difficulty: difficulty,
      score: score,
      totalQuestions: totalQuestions,
      bestScore: bestScore,
      isNewBest: isNewBest,
      completedAt: completedAt,
      answers: parsedAnswers,
    );
  }

  Map<String, Object> toJson() {
    final result = <String, Object>{
      'id': id,
      'difficulty': difficulty.name,
      'score': score,
      'totalQuestions': totalQuestions,
      'bestScore': bestScore,
      'isNewBest': isNewBest,
      'completedAt': completedAt.toIso8601String(),
    };

    final answers = _answers;
    if (answers != null && answers.isNotEmpty) {
      result['answers'] = answers.map((a) => a.toJson()).toList();
    }

    return result;
  }
}
