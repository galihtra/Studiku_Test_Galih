import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizAnswerTile extends StatelessWidget {
  const QuizAnswerTile({
    required this.index,
    required this.answer,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.onTap,
    super.key,
  });

  final int index;
  final String answer;
  final String correctAnswer;
  final String? selectedAnswer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasAnswered = selectedAnswer != null;
    final isSelected = selectedAnswer == answer;
    final isCorrect = answer == correctAnswer;
    final showCorrect = hasAnswered && isCorrect;
    final showWrong = hasAnswered && isSelected && !isCorrect;
    const idleColors = [
      Color(0xFFE1F3FF),
      AppColors.mint,
      Color(0xFFFFF4CB),
      Color(0xFFF3E8FF),
    ];
    final color = showCorrect
        ? AppColors.success
        : showWrong
        ? AppColors.danger
        : AppColors.blue;
    final background = showCorrect
        ? AppColors.mint
        : showWrong
        ? const Color(0xFFFFE8EC)
        : idleColors[index % idleColors.length];

    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Pilihan ${String.fromCharCode(65 + index)}: $answer',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: Key('answer_$index'),
          onTap: hasAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(19.r),
          child: AnimatedContainer(
            duration: AppValues.buttonAnimation,
            height: 78.h.clamp(70.0, 86.0),
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(19.r),
              border: Border.all(
                color: showCorrect || showWrong
                    ? color
                    : AppColors.deepNavy.withValues(alpha: .06),
                width: showCorrect || showWrong ? 2 : 1,
              ),
              boxShadow: const [
                BoxShadow(color: Color(0x12123A82), offset: Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  answer,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 24.sp.clamp(21.0, 28.0),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (showCorrect || showWrong) ...[
                  SizedBox(width: 7.w),
                  Icon(
                    showCorrect ? LucideIcons.circleCheck : LucideIcons.circleX,
                    color: color,
                    size: 21.r,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
