import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/logic/quiz_session_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/content_frame.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty_badge.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/gradient_progress.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/quiz_answer_feedback.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/quiz_answer_tile.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/quiz_question_card.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/quiz/round_icon_button.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizContent extends StatelessWidget {
  const QuizContent({
    required this.difficulty,
    required this.controller,
    required this.isFinishing,
    required this.onExit,
    required this.onAdvance,
    super.key,
  });

  final QuizDifficulty difficulty;
  final QuizSessionController controller;
  final bool isFinishing;
  final VoidCallback onExit;
  final VoidCallback onAdvance;

  @override
  Widget build(BuildContext context) {
    final question = controller.currentQuestion;
    return ContentFrame(
      padding: EdgeInsets.fromLTRB(
        AppLayout.pageInset,
        12.h,
        AppLayout.pageInset,
        18.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              RoundIconButton(
                tooltip: 'Keluar dari quiz',
                icon: LucideIcons.x,
                onPressed: onExit,
              ),
              SizedBox(width: 10.w),
              DifficultyBadge(difficulty: difficulty),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 9.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .94),
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.star,
                      color: AppColors.warning,
                      size: 19.r,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      AppStrings.quizScore(controller.score),
                      key: const Key('quiz_score'),
                      style: TextStyle(
                        color: AppColors.deepNavy,
                        fontSize: 14.sp.clamp(13.0, 16.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 17.h),
          Row(
            children: [
              Text(
                AppStrings.questionProgress(
                  controller.currentIndex + 1,
                  controller.totalQuestions,
                ),
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 13.sp.clamp(12.0, 15.0),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Text(
                '${(controller.progress * 100).round()}%',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 12.sp.clamp(11.0, 14.0),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          GradientProgress(value: controller.progress),
          SizedBox(height: 18.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizQuestionCard(controller: controller),
                  SizedBox(height: 15.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final spacing = 11.w;
                      final tileWidth = (constraints.maxWidth - spacing) / 2;
                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: [
                          for (
                            var index = 0;
                            index < question.options.length;
                            index++
                          )
                            SizedBox(
                              width: tileWidth,
                              child: QuizAnswerTile(
                                index: index,
                                answer: question.options[index],
                                correctAnswer: question.correctAnswer,
                                selectedAnswer: controller.selectedAnswer,
                                onTap: () =>
                                    controller.answer(question.options[index]),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  if (controller.hasAnswered) ...[
                    SizedBox(height: 14.h),
                    QuizAnswerFeedback(
                      isCorrect: controller.selectedAnswerIsCorrect,
                      correctAnswer: question.correctAnswer,
                    ),
                  ],
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          KalkumiPrimaryButton(
            keyValue: const Key('next_question_button'),
            label: isFinishing
                ? AppStrings.savingResult
                : controller.isLastQuestion
                ? AppStrings.viewResult
                : AppStrings.nextQuestion,
            icon: controller.isLastQuestion
                ? LucideIcons.flag
                : LucideIcons.arrowRight,
            enabled: controller.hasAnswered && !isFinishing,
            onPressed: controller.hasAnswered && !isFinishing
                ? onAdvance
                : null,
          ),
        ],
      ),
    );
  }
}
