import 'dart:convert';

import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class QuizHistoryRepository {
  Future<List<QuizHistoryEntry>> getAll();

  Future<List<QuizHistoryEntry>> add(QuizHistoryEntry entry);
}

class SharedPreferencesQuizHistoryRepository implements QuizHistoryRepository {
  @override
  Future<List<QuizHistoryEntry>> getAll() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getString(AppValues.historyStorageKey);
    if (encoded == null || encoded.isEmpty) return const [];

    final decoded = jsonDecode(encoded);
    if (decoded is! List<Object?>) {
      throw const FormatException('Penyimpanan riwayat bukan sebuah list.');
    }

    final entries =
        decoded
            .map((item) {
              if (item is! Map<String, Object?>) {
                throw const FormatException('Item riwayat tidak valid.');
              }
              return QuizHistoryEntry.fromJson(item);
            })
            .toList(growable: false)
          ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return List.unmodifiable(entries.take(AppValues.maxHistoryEntries));
  }

  @override
  Future<List<QuizHistoryEntry>> add(QuizHistoryEntry entry) async {
    final previous = await getAll();
    final entries = [entry, ...previous.where((item) => item.id != entry.id)]
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    final limited = entries.take(AppValues.maxHistoryEntries).toList();
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(
      AppValues.historyStorageKey,
      jsonEncode(limited.map((item) => item.toJson()).toList()),
    );
    if (!saved) throw StateError('Riwayat tidak dapat disimpan.');
    return List.unmodifiable(limited);
  }
}
