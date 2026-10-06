import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResultHero extends StatelessWidget {
  const ResultHero({
    required this.score,
    required this.headline,
    required this.message,
    required this.accentColor,
    super.key,
  });

  final int score;
  final String headline;
  final String message;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h.clamp(235.0, 280.0),
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
            right: 6.w,
            bottom: -6.h,
            child: Image.asset(
              score >= 6
                  ? KalkumiAssets.mascotCelebrating
                  : KalkumiAssets.mascotEncouraging,
              width: 165.w.clamp(150.0, 180.0),
              height: 175.h.clamp(160.0, 192.0),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 20.w,
            top: 19.h,
            child: Icon(
              LucideIcons.sparkles,
              color: AppColors.warning,
              size: 27.r,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              21.w.clamp(18.0, 28.0),
              21.h,
              146.w.clamp(132.0, 165.0),
              21.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.flag,
                      color: AppColors.warning,
                      size: 16.r,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'ROUND COMPLETE',
                      style: TextStyle(
                        color: AppColors.warning,
                        fontSize: 10.sp.clamp(9.0, 12.0),
                        fontWeight: FontWeight.w900,
                        letterSpacing: .8,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    headline,
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
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .82),
                    fontSize: 11.sp.clamp(10.0, 13.0),
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                Text.rich(
                  key: const Key('result_score'),
                  TextSpan(
                    children: [
                      TextSpan(text: '$score'),
                      TextSpan(
                        text: '/${AppValues.questionsPerSession}',
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
