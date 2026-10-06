abstract final class AppStrings {
  static const appName = 'Kalkumi';
  static const homeHeroTitle = 'Siap jadi\njagoan matematika?';
  static const chooseLevel = 'Pilih Level';
  static const choosePower = 'Pilih kekuatanmu';
  static const difficultyHeroEyebrow = 'SIAPKAN LATIHANMU';
  static const difficultyHeroTitle = 'Pilih level\ntantanganmu';
  static const difficultyHeroSubtitle = 'Mulai dari level nyamanmu.';
  static const historyTitle = 'Riwayat permainan';
  static const historySubtitle = 'Lihat lagi hasil latihan terakhirmu';
  static const historyEmptyTitle = 'Belum ada riwayat';
  static const historyEmptyBody =
      'Selesaikan satu sesi quiz dan hasilnya akan muncul di sini.';
  static const historyLoadErrorTitle = 'Riwayat tidak tampil';
  static const historyLoadErrorBody =
      'Data lokal belum dapat dibaca. Quiz tetap bisa dimainkan.';
  static const historyNotFoundTitle = 'Hasil tidak ditemukan';
  static const historyNotFoundBody =
      'Riwayat ini mungkin sudah tidak tersedia di perangkat.';
  static const retry = 'Coba lagi';
  static const backToHome = 'Kembali ke Beranda';
  static const playAgain = 'Main Lagi';
  static const changeDifficulty = 'Ganti Kesulitan';
  static const resultTitle = 'HASIL PETUALANGAN';
  static const historyResultTitle = 'DETAIL HASIL';
  static const localStorageError =
      'Hasil sesi tetap valid, tetapi sebagian data lokal belum tersimpan.';

  static String bestScore(int score) => 'Best $score/10';
  static String quizScore(int score) => '$score poin';
  static String questionProgress(int current, int total) =>
      'Soal $current dari $total';
  static String scoreFraction(int score, int total) => '$score/$total';
  static String correctAnswers(int score) => '$score jawaban benar';
}
