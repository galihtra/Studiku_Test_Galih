import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/domain/quiz_result_args.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/logic/quiz_session_controller.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/quiz_content.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/quiz_load_error.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({required this.difficulty, super.key});

  final QuizDifficulty difficulty;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _isFinishing = false;

  Future<bool> _confirmExit() async {
    final shouldExit = await showShadDialog<bool>(
      context: context,
      builder: (dialogContext) => ShadDialog.alert(
        title: const Text(AppStrings.quizExitTitle),
        description: const Text(AppStrings.quizExitBody),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text(AppStrings.quizExitCancel),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(AppStrings.quizExitConfirm),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }

  Future<void> _handleBack() async {
    if (await _confirmExit() && mounted) context.pop();
  }

  Future<void> _advance(QuizSessionController controller) async {
    if (!controller.hasAnswered || _isFinishing) return;
    if (!controller.isLastQuestion) {
      controller.advance();
      return;
    }

    setState(() => _isFinishing = true);
    controller.advance();
    var persistenceFailed = false;
    final scoreboard = context.read<ScoreboardController>();
    final history = context.read<QuizHistoryController>();
    ScoreUpdate update;
    try {
      update = await scoreboard.saveScore(widget.difficulty, controller.score);
    } catch (_) {
      persistenceFailed = true;
      update = ScoreUpdate(
        bestScore: scoreboard.bestFor(widget.difficulty),
        isNewBest: false,
      );
    }

    final entry = QuizHistoryEntry.create(
      difficulty: widget.difficulty,
      score: controller.score,
      bestScore: update.bestScore,
      isNewBest: update.isNewBest,
      answers: controller.answers,
    );
    try {
      await history.add(entry);
    } catch (_) {
      persistenceFailed = true;
    }
    if (!mounted) return;

    context.pushReplacement(
      AppRoutes.result,
      extra: QuizResultArgs(entry: entry, persistenceFailed: persistenceFailed),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<QuizSessionController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        body: KalkumiBackdrop(
          child: SafeArea(
            child: controller.hasLoadError
                ? QuizLoadError(controller: controller)
                : QuizContent(
                    difficulty: widget.difficulty,
                    controller: controller,
                    isFinishing: _isFinishing,
                    onExit: _handleBack,
                    onAdvance: () => _advance(controller),
                  ),
          ),
        ),
      ),
    );
  }
}
