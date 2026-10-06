import 'package:flutter/material.dart';
import 'package:kalkumi/app.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(KalkumiApp(scoreRepository: SharedPreferencesBestScoreRepository()));
}
