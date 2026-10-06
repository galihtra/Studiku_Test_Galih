import 'package:flutter_test/flutter_test.dart';
import 'package:kalkumi/features/quiz/data/quiz_history_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/resources/values_app.dart';

class _ControllableHistoryRepository implements QuizHistoryRepository {
  bool shouldFail = false;
  List<QuizHistoryEntry> entries = [];

  void _checkFailure() {
    if (shouldFail) throw StateError('Simulated history failure');
  }

  @override
  Future<List<QuizHistoryEntry>> add(QuizHistoryEntry entry) async {
    _checkFailure();
    entries = [entry, ...entries.where((item) => item.id != entry.id)];
    return List.unmodifiable(entries);
  }

  @override
  Future<List<QuizHistoryEntry>> getAll() async {
    _checkFailure();
    return List.unmodifiable(entries);
  }
}

void main() {
  test(
    'controller mengekspos entry dan pencarian detail berdasarkan id',
    () async {
      final repository = _ControllableHistoryRepository();
      final entry = _entry('history-1');
      repository.entries = [entry];
      final controller = QuizHistoryController(repository);
      addTearDown(controller.dispose);

      await controller.load();

      expect(controller.status, QuizHistoryStatus.success);
      expect(controller.findById('history-1'), same(entry));
      expect(controller.findById('missing'), isNull);
    },
  );

  test('read failure menjadi state error dan sukses setelah retry', () async {
    final repository = _ControllableHistoryRepository()..shouldFail = true;
    final controller = QuizHistoryController(repository);
    addTearDown(controller.dispose);

    await controller.load();
    expect(controller.hasError, isTrue);
    expect(controller.errorMessage, isNotEmpty);

    repository
      ..shouldFail = false
      ..entries = [_entry('recovered')];
    await controller.load();

    expect(controller.hasError, isFalse);
    expect(controller.entries.single.id, 'recovered');
  });

  test('streak menghitung tanggal unik yang berurutan', () async {
    final clock = DateTime.now();
    final now = DateTime(clock.year, clock.month, clock.day, 12);
    final repository = _ControllableHistoryRepository()
      ..entries = [
        _entryAt('today-a', now),
        _entryAt('today-b', now.subtract(const Duration(hours: 1))),
        _entryAt('yesterday', now.subtract(const Duration(days: 1))),
        _entryAt('two-days', now.subtract(const Duration(days: 2))),
        _entryAt('gap', now.subtract(const Duration(days: 4))),
      ];
    final controller = QuizHistoryController(repository);
    addTearDown(controller.dispose);

    await controller.load();

    expect(controller.currentStreak, 3);
  });
}

QuizHistoryEntry _entry(String id) => QuizHistoryEntry(
  id: id,
  difficulty: QuizDifficulty.easy,
  score: 8,
  totalQuestions: AppValues.questionsPerSession,
  bestScore: 8,
  isNewBest: true,
  completedAt: DateTime(2026, 1, 1),
);

QuizHistoryEntry _entryAt(String id, DateTime completedAt) => QuizHistoryEntry(
  id: id,
  difficulty: QuizDifficulty.easy,
  score: 8,
  totalQuestions: AppValues.questionsPerSession,
  bestScore: 8,
  isNewBest: true,
  completedAt: completedAt,
);
