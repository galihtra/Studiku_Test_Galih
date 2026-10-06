import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/domain/question_answer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    required this.questionNumber,
    required this.answer,
    super.key,
  });

  final int questionNumber;
  final QuestionAnswer answer;

  @override
  Widget build(BuildContext context) {
    final statusColor = answer.isCorrect ? AppColors.success : AppColors.danger;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withValues(alpha: .2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
            color: statusColor.withValues(alpha: .08),
            child: Row(
              children: [
                Container(
                  width: 25.r,
                  height: 25.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: .14),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$questionNumber',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(width: 9.w),
                Icon(
                  answer.isCorrect
                      ? LucideIcons.circleCheck
                      : LucideIcons.circleX,
                  color: statusColor,
                  size: 18.r,
                ),
                SizedBox(width: 6.w),
                Text(
                  answer.isCorrect ? 'Benar' : 'Salah',
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    answer.questionPrompt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 13.sp.clamp(12.0, 15.0),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                for (final option in answer.options)
                  _optionChip(
                    option,
                    isSelected: option == answer.userAnswer,
                    isCorrect: option == answer.correctAnswer,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionChip(
    String option, {
    required bool isSelected,
    required bool isCorrect,
  }) {
    final color = isCorrect
        ? AppColors.success
        : isSelected
        ? AppColors.danger
        : AppColors.muted;
    final background = isCorrect
        ? AppColors.mint
        : isSelected
        ? const Color(0xFFFFE8EC)
        : AppColors.background;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(color: color.withValues(alpha: .35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCorrect || isSelected) ...[
            Icon(
              isCorrect ? LucideIcons.check : LucideIcons.x,
              size: 13.r,
              color: color,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            option,
            style: TextStyle(
              color: color,
              fontSize: 13.sp.clamp(12.0, 15.0),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
