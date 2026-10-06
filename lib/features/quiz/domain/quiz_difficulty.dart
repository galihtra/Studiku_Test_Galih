enum QuizDifficulty { easy, medium, hard }

extension QuizDifficultyX on QuizDifficulty {
  String get label => switch (this) {
    QuizDifficulty.easy => 'Easy',
    QuizDifficulty.medium => 'Medium',
    QuizDifficulty.hard => 'Hard',
  };

  String get description => switch (this) {
    QuizDifficulty.easy => 'Tambah dan kurang sampai 20.',
    QuizDifficulty.medium => 'Hitung sampai 100 dan perkalian 2-12.',
    QuizDifficulty.hard => 'Ekspresi dua langkah dengan empat operasi.',
  };

  String get tagline => switch (this) {
    QuizDifficulty.easy => 'Pemanasan santai',
    QuizDifficulty.medium => 'Nyalakan kekuatan',
    QuizDifficulty.hard => 'Buktikan kemampuanmu',
  };

  String get storageKey => 'best_score_${name.toLowerCase()}';
}
