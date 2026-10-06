import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/metric_divider.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/result/result_metric_item.dart';
import 'package:kalkumi/resources/values_app.dart';

class ResultPerformanceCard extends StatelessWidget {
  const ResultPerformanceCard({
    required this.score,
    required this.bestScore,
    required this.accentColor,
    super.key,
  });

  final int score;
  final int bestScore;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final accuracy = score / AppValues.questionsPerSession;
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
            'HASIL SESIMU',
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
                        value: accuracy,
                        strokeWidth: 10.r,
                        strokeCap: StrokeCap.round,
                        color: accentColor,
                        backgroundColor: accentColor.withValues(alpha: .13),
                      ),
                    ),
                    Text(
                      '${(accuracy * 100).round()}%',
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
                      score >= 8
                          ? 'Fokus luar biasa!'
                          : score >= 5
                          ? 'Terus bangun ritme!'
                          : 'Ayo coba lagi!',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 18.sp.clamp(16.0, 21.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    const Text(
                      'Akurasi jawaban',
                      style: TextStyle(color: AppColors.muted),
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
                child: ResultMetricItem(
                  value: '$score',
                  label: 'Benar',
                  color: AppColors.success,
                ),
              ),
              const MetricDivider(),
              Expanded(
                child: ResultMetricItem(
                  value: '${AppValues.questionsPerSession - score}',
                  label: 'Salah',
                  color: AppColors.danger,
                ),
              ),
              const MetricDivider(),
              Expanded(
                child: ResultMetricItem(
                  value: '$bestScore',
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
