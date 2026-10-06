import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/content_frame.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty_badge.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_metrics_card.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_question_answers.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_record_banner.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_result_hero.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryResultView extends StatelessWidget {
  const HistoryResultView({required this.entry, super.key});

  final QuizHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final accent = historyAccentColor(entry.accuracy);
    return SingleChildScrollView(
      child: ContentFrame(
        padding: AppLayout.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.historyResultTitle,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11.sp.clamp(10.0, 13.0),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                DifficultyBadge(difficulty: entry.difficulty),
              ],
            ),
            SizedBox(height: 14.h),
            if (entry.isNewBest) ...[
              const HistoryRecordBanner(),
              SizedBox(height: 14.h),
            ],
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    color: accent.withValues(alpha: .25),
                    blurRadius: 22,
                    offset: const Offset(0, 11),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HistoryResultHero(entry: entry, accentColor: accent),
                  HistoryMetricsCard(entry: entry, accentColor: accent),
                ],
              ),
            ),
            if (entry.answers.isNotEmpty) ...[
              SizedBox(height: 20.h),
              HistoryQuestionAnswers(answers: entry.answers),
            ],
            SizedBox(height: 20.h),
            KalkumiPrimaryButton(
              label: AppStrings.playAgain,
              icon: LucideIcons.rotateCcw,
              onPressed: () => context.push(AppRoutes.quiz(entry.difficulty)),
            ),
            SizedBox(height: 11.h),
            ShadButton.outline(
              width: double.infinity,
              height: AppLayout.buttonHeight,
              onPressed: () => context.go(AppRoutes.home),
              leading: const Icon(LucideIcons.house),
              child: const Text(AppStrings.backToHome),
            ),
          ],
        ),
      ),
    );
  }
}

Color historyAccentColor(int accuracy) {
  if (accuracy >= 80) return AppColors.success;
  if (accuracy >= 50) return AppColors.blue;
  return AppColors.deepNavy;
}
