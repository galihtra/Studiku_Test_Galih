import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/domain/question_answer.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/answer_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryQuestionAnswers extends StatelessWidget {
  const HistoryQuestionAnswers({required this.answers, super.key});

  final List<QuestionAnswer> answers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.listChecks, color: AppColors.blue, size: 18.r),
            SizedBox(width: 8.w),
            Text(
              'DETAIL JAWABAN',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 11.sp.clamp(10.0, 13.0),
                fontWeight: FontWeight.w900,
                letterSpacing: .8,
              ),
            ),
            const Spacer(),
            Text(
              '${answers.where((answer) => answer.isCorrect).length}/${answers.length} benar',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 11.sp.clamp(10.0, 13.0),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        for (var index = 0; index < answers.length; index++) ...[
          AnswerTile(questionNumber: index + 1, answer: answers[index]),
          if (index != answers.length - 1) SizedBox(height: 10.h),
        ],
      ],
    );
  }
}
