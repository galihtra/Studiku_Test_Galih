import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizAnswerFeedback extends StatelessWidget {
  const QuizAnswerFeedback({
    required this.isCorrect,
    required this.correctAnswer,
    super.key,
  });

  final bool isCorrect;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.success : AppColors.danger;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(17.r),
        border: Border.all(color: color.withValues(alpha: .18)),
      ),
      child: Row(
        children: [
          Icon(
            isCorrect ? LucideIcons.circleCheck : LucideIcons.heartHandshake,
            color: color,
            size: 20.r,
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              isCorrect
                  ? 'Yes! Math power-mu bertambah.'
                  : 'Belum tepat. Jawaban benar: $correctAnswer',
              style: TextStyle(
                color: color,
                fontSize: 13.sp.clamp(12.0, 15.0),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
