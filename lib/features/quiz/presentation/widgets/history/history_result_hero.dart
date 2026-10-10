import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/core/extensions/date_time_ext.dart';
import 'package:kalkumi/core/extensions/score_ext.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryResultHero extends StatelessWidget {
  const HistoryResultHero({
    required this.entry,
    required this.accentColor,
    super.key,
  });

  final QuizHistoryEntry entry;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.h.clamp(215.0, 260.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accentColor, AppColors.blue],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 5.w,
            bottom: -8.h,
            child: Image.asset(
              entry.accuracy >= 60
                  ? KalkumiAssets.mascotCelebrating
                  : KalkumiAssets.mascotEncouraging,
              width: 163.w.clamp(148.0, 178.0),
              height: 176.h.clamp(160.0, 192.0),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              21.w.clamp(18.0, 28.0),
              22.h.clamp(18.0, 26.0),
              145.w.clamp(130.0, 165.0),
              20.h.clamp(17.0, 24.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.history,
                      color: AppColors.warning,
                      size: 17.r,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'SESI SELESAI',
                      style: TextStyle(
                        color: AppColors.warning,
                        fontSize: 10.sp.clamp(9.0, 12.0),
                        fontWeight: FontWeight.w900,
                        letterSpacing: .8,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    entry.accuracy.toHistoryHeadline(),
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp.clamp(21.0, 28.0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  entry.completedAt.toFormattedString(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .8),
                    fontSize: 11.sp.clamp(10.0, 13.0),
                  ),
                ),
                const Spacer(),
                Text.rich(
                  key: const Key('history_result_score'),
                  TextSpan(
                    children: [
                      TextSpan(text: '${entry.score}'),
                      TextSpan(
                        text: '/${entry.totalQuestions}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .68),
                          fontSize: 20.sp.clamp(18.0, 23.0),
                        ),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 47.sp.clamp(40.0, 52.0),
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'TOTAL SCORE',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .68),
                    fontSize: 9.sp.clamp(8.0, 11.0),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
