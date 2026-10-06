import 'package:flutter/material.dart';

abstract final class AppValues {
  static const designSize = Size(390, 844);
  static const questionsPerSession = 10;
  static const answerOptions = 4;
  static const difficultyCount = 3;
  static const maxHistoryEntries = 20;
  static const homeHistoryPageSize = 4;
  static const contentMaxWidth = 680.0;
  static const historyStorageKey = 'kalkumi.quiz_history.v1';
  static const primaryAnimation = Duration(milliseconds: 280);
  static const buttonAnimation = Duration(milliseconds: 180);
  static const splashAnimationDuration = Duration(milliseconds: 700);
  static const splashDisplayDuration = Duration(seconds: 2);
}
