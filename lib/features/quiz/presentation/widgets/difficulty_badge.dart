import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension DifficultyVisuals on QuizDifficulty {
  Color get color => switch (this) {
    QuizDifficulty.easy => AppColors.success,
    QuizDifficulty.medium => AppColors.blue,
    QuizDifficulty.hard => AppColors.danger,
  };

  Color get paleColor => switch (this) {
    QuizDifficulty.easy => AppColors.mint,
    QuizDifficulty.medium => const Color(0xFFE8F2FF),
    QuizDifficulty.hard => const Color(0xFFFFE8EC),
  };

  IconData get icon => switch (this) {
    QuizDifficulty.easy => LucideIcons.leaf,
    QuizDifficulty.medium => LucideIcons.zap,
    QuizDifficulty.hard => LucideIcons.flame,
  };
}

class DifficultyBadge extends StatelessWidget {
  const DifficultyBadge({required this.difficulty, super.key});

  final QuizDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: difficulty.paleColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(difficulty.icon, size: 17.r, color: difficulty.color),
          SizedBox(width: 6.w),
          Text(
            difficulty.label,
            style: TextStyle(
              color: difficulty.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
