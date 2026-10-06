import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';

class QuizResultArgs {
  const QuizResultArgs({required this.entry, required this.persistenceFailed});

  final QuizHistoryEntry entry;
  final bool persistenceFailed;
}
