import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const home = '/';
  static const difficulty = '/difficulty';
  static const quizName = 'quiz';
  static const quizPattern = '/quiz/:difficulty';
  static const result = '/result';
  static const historyDetailName = 'history-detail';
  static const historyDetailPattern = '/history/:id';

  static String quiz(QuizDifficulty difficulty) => '/quiz/${difficulty.name}';
  static String historyDetail(String id) => '/history/$id';
}
