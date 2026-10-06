import 'package:flutter/foundation.dart';
import 'package:kalkumi/features/quiz/data/quiz_history_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';

enum QuizHistoryStatus { initial, loading, success, failure }

class QuizHistoryController extends ChangeNotifier {
  QuizHistoryController(this._repository);

  final QuizHistoryRepository _repository;

  QuizHistoryStatus _status = QuizHistoryStatus.initial;
  List<QuizHistoryEntry> _entries = const [];
  String? _errorMessage;

  QuizHistoryStatus get status => _status;
  List<QuizHistoryEntry> get entries => List.unmodifiable(_entries);
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == QuizHistoryStatus.loading;
  bool get hasError => _status == QuizHistoryStatus.failure;
  bool get isEmpty => _entries.isEmpty;

  int get currentStreak {
    if (_entries.isEmpty) return 0;
    final days =
        _entries
            .map((entry) {
              final local = entry.completedAt.toLocal();
              return DateTime(local.year, local.month, local.day);
            })
            .toSet()
            .toList()
          ..sort((a, b) => b.compareTo(a));

    final current = DateTime.now();
    final today = DateTime(current.year, current.month, current.day);
    final daysSinceLatest = today.difference(days.first).inDays;
    if (daysSinceLatest < 0 || daysSinceLatest > 1) return 0;

    var streak = 1;
    for (var index = 1; index < days.length; index++) {
      if (days[index - 1].difference(days[index]).inDays != 1) break;
      streak += 1;
    }
    return streak;
  }

  QuizHistoryEntry? findById(String id) =>
      _entries.where((entry) => entry.id == id).firstOrNull;

  Future<void> load() async {
    if (_status == QuizHistoryStatus.loading) return;
    _status = QuizHistoryStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _entries = await _repository.getAll();
      _status = QuizHistoryStatus.success;
    } catch (error) {
      if (kDebugMode) debugPrint('Gagal memuat riwayat quiz: $error');
      _status = QuizHistoryStatus.failure;
      _errorMessage = 'Riwayat belum dapat dimuat dari penyimpanan lokal.';
    }
    notifyListeners();
  }

  Future<void> add(QuizHistoryEntry entry) async {
    try {
      _entries = await _repository.add(entry);
      _status = QuizHistoryStatus.success;
      _errorMessage = null;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) debugPrint('Gagal menyimpan riwayat quiz: $error');
      rethrow;
    }
  }
}
