import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:kalkumi/features/quiz/data/question_generator.dart';
import 'package:kalkumi/features/quiz/domain/question.dart';
import 'package:kalkumi/features/quiz/domain/question_answer.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/resources/values_app.dart';

class QuizSessionController extends ChangeNotifier {
  QuizSessionController({
    required this.difficulty,
    QuestionGenerator generator = const QuestionGenerator(),
    Random? random,
  }) : _generator = generator,
       _random = random {
    _loadQuestions();
  }

  final QuizDifficulty difficulty;
  final QuestionGenerator _generator;
  final Random? _random;

  List<Question> _questions = const [];
  String? _loadError;

  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  bool _isComplete = false;
  final List<QuestionAnswer> _answers = [];

  List<Question> get questions => _questions;
  List<QuestionAnswer> get answers => List.unmodifiable(_answers);
  Question get currentQuestion {
    if (_questions.isEmpty) {
      throw StateError('Question data is not available.');
    }
    return _questions[_currentIndex];
  }

  int get currentIndex => _currentIndex;
  int get score => _score;
  int get totalQuestions => _questions.length;
  String? get loadError => _loadError;
  bool get hasLoadError => _loadError != null;
  String? get selectedAnswer => _selectedAnswer;
  bool get hasAnswered => _selectedAnswer != null;
  bool get isLastQuestion =>
      _questions.isNotEmpty && _currentIndex == _questions.length - 1;
  bool get isComplete => _isComplete;
  double get progress =>
      _questions.isEmpty ? 0 : (_currentIndex + 1) / _questions.length;

  bool get selectedAnswerIsCorrect =>
      !hasLoadError &&
      _selectedAnswer != null &&
      currentQuestion.isCorrect(_selectedAnswer!);

  void _loadQuestions() {
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;
    _isComplete = false;
    _loadError = null;
    _answers.clear();

    try {
      final generated = _generator.generate(difficulty, random: _random);
      if (generated.length != AppValues.questionsPerSession ||
          generated.any(
            (question) =>
                question.options.length != AppValues.answerOptions ||
                !question.options.contains(question.correctAnswer),
          )) {
        throw const FormatException('Question data is incomplete.');
      }
      _questions = generated;
    } catch (error) {
      if (kDebugMode) debugPrint('Gagal menyiapkan soal: $error');
      _questions = const [];
      _loadError =
          'Soal belum dapat ditampilkan. Periksa data soal lalu coba lagi.';
    }
  }

  void retry() {
    _loadQuestions();
    notifyListeners();
  }

  void answer(String answer) {
    if (hasLoadError ||
        _isComplete ||
        hasAnswered ||
        !currentQuestion.options.contains(answer)) {
      return;
    }

    _selectedAnswer = answer;
    if (currentQuestion.isCorrect(answer)) {
      _score += 1;
    }

    _answers.add(
      QuestionAnswer(
        questionPrompt: currentQuestion.prompt,
        options: List.from(currentQuestion.options),
        correctAnswer: currentQuestion.correctAnswer,
        userAnswer: answer,
      ),
    );

    notifyListeners();
  }

  bool advance() {
    if (!hasAnswered || _isComplete) {
      return false;
    }

    if (isLastQuestion) {
      _isComplete = true;
      notifyListeners();
      return true;
    }

    _currentIndex += 1;
    _selectedAnswer = null;
    notifyListeners();
    return false;
  }
}
