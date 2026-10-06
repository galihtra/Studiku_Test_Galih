import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'menyimpan skor tertinggi dan tidak menimpanya dengan skor lebih rendah',
    () async {
      final repository = SharedPreferencesBestScoreRepository();

      final first = await repository.saveIfHigher(QuizDifficulty.hard, 8);
      final second = await repository.saveIfHigher(QuizDifficulty.hard, 5);

      expect(first.isNewBest, isTrue);
      expect(first.bestScore, 8);
      expect(second.isNewBest, isFalse);
      expect(second.bestScore, 8);
      expect(await repository.getBest(QuizDifficulty.hard), 8);
    },
  );

  test('skor tiap tingkat kesulitan disimpan terpisah', () async {
    final repository = SharedPreferencesBestScoreRepository();

    await repository.saveIfHigher(QuizDifficulty.easy, 9);
    await repository.saveIfHigher(QuizDifficulty.medium, 6);
    final scores = await repository.getAll();

    expect(scores[QuizDifficulty.easy], 9);
    expect(scores[QuizDifficulty.medium], 6);
    expect(scores[QuizDifficulty.hard], 0);
  });
}
