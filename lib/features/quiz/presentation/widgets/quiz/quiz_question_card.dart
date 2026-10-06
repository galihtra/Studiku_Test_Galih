import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/logic/quiz_session_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({required this.controller, super.key});
  final QuizSessionController controller;

  String get _mascot {
    if (!controller.hasAnswered) return KalkumiAssets.mascotThinking;
    return controller.selectedAnswerIsCorrect
        ? KalkumiAssets.mascotHappy
        : KalkumiAssets.mascotEncouraging;
  }

  @override
  Widget build(BuildContext context) {
    return KalkumiSurfaceCard(
      padding: EdgeInsets.fromLTRB(18.w, 15.h, 18.w, 21.h),
      borderRadius: BorderRadius.circular(28.r),
      borderColor: AppColors.blue.withValues(alpha: .16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColors.sky,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.calculator,
                      color: AppColors.blue,
                      size: 15.r,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'HITUNG INI!',
                      style: TextStyle(
                        color: AppColors.blue,
                        fontSize: 10.sp.clamp(9.0, 12.0),
                        fontWeight: FontWeight.w900,
                        letterSpacing: .6,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Image.asset(
                  _mascot,
                  key: ValueKey(_mascot),
                  width: 72.w.clamp(66.0, 82.0),
                  height: 68.h.clamp(62.0, 78.0),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              controller.currentQuestion.prompt,
              key: const Key('question_text'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 35.sp.clamp(30.0, 40.0),
                fontWeight: FontWeight.w900,
                letterSpacing: -.8,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            controller.hasAnswered
                ? controller.selectedAnswerIsCorrect
                      ? 'Hebat! Jawabanmu tepat.'
                      : 'Hampir! Lihat jawaban yang benar.'
                : 'Pilih satu jawaban di bawah',
            style: TextStyle(
              color: controller.hasAnswered
                  ? controller.selectedAnswerIsCorrect
                        ? AppColors.success
                        : AppColors.danger
                  : AppColors.muted,
              fontSize: 12.sp.clamp(11.0, 14.0),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
