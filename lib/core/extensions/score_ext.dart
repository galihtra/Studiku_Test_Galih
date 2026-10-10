// lib/core/extensions/score_ext.dart
extension ScoreExt on int {
  String toHistoryHeadline() {
    if (this >= 90) return 'Math superstar!';
    if (this >= 70) return 'Ritmemu keren!';
    if (this >= 50) return 'Makin kuat!';
    return 'Terus berlatih!';
  }
}
