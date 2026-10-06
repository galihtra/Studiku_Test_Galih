import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_metric_item.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/metric_divider.dart';

class HistoryMetricsCard extends StatelessWidget {
  const HistoryMetricsCard({
    required this.entry,
    required this.accentColor,
    super.key,
  });

  final QuizHistoryEntry entry;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface.withValues(alpha: 0.97),
      padding: EdgeInsets.fromLTRB(
        21.w.clamp(18.0, 28.0),
        18.h,
        21.w.clamp(18.0, 28.0),
        24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RINGKASAN SESI',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 11.sp.clamp(10.0, 13.0),
              fontWeight: FontWeight.w900,
              letterSpacing: .8,
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              SizedBox(
                width: 88.r,
                height: 88.r,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: entry.accuracy / 100,
                        strokeWidth: 10.r,
                        strokeCap: StrokeCap.round,
                        color: accentColor,
                        backgroundColor: accentColor.withValues(alpha: .13),
                      ),
                    ),
                    Text(
                      '${entry.accuracy}%',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 20.sp.clamp(18.0, 23.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.difficulty.tagline,
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 18.sp.clamp(16.0, 21.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Akurasi jawaban pada sesi ini',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 13.sp.clamp(12.0, 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          const Divider(color: AppColors.border),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: HistoryMetricItem(
                  value: '${entry.score}',
                  label: 'Benar',
                  color: AppColors.success,
                ),
              ),
              const MetricDivider(),
              Expanded(
                child: HistoryMetricItem(
                  value: '${entry.incorrectAnswers}',
                  label: 'Salah',
                  color: AppColors.danger,
                ),
              ),
              const MetricDivider(),
              Expanded(
                child: HistoryMetricItem(
                  value: '${entry.bestScore}',
                  label: 'Terbaik',
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
