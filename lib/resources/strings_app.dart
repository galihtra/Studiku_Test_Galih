abstract final class AppStrings {
  static const appName = 'Kalkumi';
  static const homeHeroTitle = 'Siap jadi\njagoan matematika?';
  static const chooseLevel = 'Pilih Level';
  static const choosePower = 'Pilih kekuatanmu';
  static const difficultyHeroEyebrow = 'SIAPKAN LATIHANMU';
  static const difficultyHeroTitle = 'Pilih level\ntantanganmu';
  static const difficultyHeroSubtitle = 'Mulai dari level nyamanmu.';
  static const journeyTitle = 'Perjalananmu';
  static const journeySubtitle = 'Sedikit latihan, makin kuat setiap hari';
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

  // Baru ditambahkan
  static const quizExitTitle = 'Keluar dari permainan?';
  static const quizExitBody = 'Progress sesi ini belum selesai dan tidak akan disimpan.';
  static const quizExitCancel = 'Lanjut bermain';
  static const quizExitConfirm = 'Keluar';
  static const quizLoadErrorTitle = 'Soal belum siap';
  static const backToChooseLevel = 'Kembali Pilih Level';
  static const loadingBestScore = 'Memuat best score';
  static const bestScoreErrorTitle = 'Best score tidak tersedia';
  static const bestScoreErrorBody = 'Kamu tetap dapat bermain. Data lokal bisa dicoba lagi.';
  static const reload = 'Muat ulang';
  static const difficultyHeroDescription = 'Setiap level punya aturan generator yang berbeda.';
  static const difficultyInfo = 'Setiap sesi berisi 10 soal baru dan hanya satu jawaban yang benar.';
  static const historyDetailAppBarTitle = 'Detail Hasil';
  static const resultNotSavedTitle = 'Hasil belum tersimpan';
  static const scoreLoadErrorTitle = 'Data skor tidak tampil';
  static const savingResult = 'Menyimpan hasil...';
  static const viewResult = 'Lihat Hasil';
  static const nextQuestion = 'Soal Berikutnya';
  
  // Baru ditambahkan part 2
  static const historyRecordBannerMessage = 'Sesi ini mencetak rekor baru!';
  static const sessionSummaryLabel = 'RINGKASAN SESI';
  static const accuracySessionLabel = 'Akurasi jawaban pada sesi ini';
  static const correctLabel = 'Benar';
  static const incorrectLabel = 'Salah';
  static const bestLabel = 'Terbaik';
  static const resultRecordBannerTitle = 'REKOR BARU!';
  static const resultRecordBannerBody = 'Best score-mu baru saja naik. Keren!';
  static const resultPerformanceLabel = 'HASIL SESIMU';
  static const resultFeedbackHigh = 'Fokus luar biasa!';
  static const resultFeedbackMed = 'Terus bangun ritme!';
  static const resultFeedbackLow = 'Ayo coba lagi!';
  static const accuracyLabel = 'Akurasi jawaban';
  static const homeHeroGreeting = 'HEY, MATH HERO! 👋';

  static String bestScore(int score) => 'Best $score/10';
  static String quizScore(int score) => '$score poin';
  static String questionProgress(int current, int total) =>
      'Soal $current dari $total';
  static String scoreFraction(int score, int total) => '$score/$total';
  static String correctAnswers(int score) => '$score jawaban benar';
}
