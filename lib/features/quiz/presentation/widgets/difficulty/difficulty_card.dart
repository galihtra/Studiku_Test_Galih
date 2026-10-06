import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty_badge.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DifficultyCard extends StatelessWidget {
  const DifficultyCard({
    required this.difficulty,
    required this.bestScore,
    required this.onTap,
    super.key,
  });

  final QuizDifficulty difficulty;
  final int bestScore;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = difficulty.color;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: Key('difficulty_${difficulty.name}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(23.r),
        child: Ink(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [difficulty.paleColor, Colors.white],
            ),
            borderRadius: BorderRadius.circular(23.r),
            border: Border.all(color: color.withValues(alpha: .24), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10123A82),
                blurRadius: 14,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 58.r,
                height: 58.r,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: .24),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(difficulty.icon, color: Colors.white, size: 28.r),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          difficulty.label,
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 19.sp.clamp(17.0, 22.0),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            difficulty.tagline,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: color,
                              fontSize: 11.sp.clamp(10.0, 13.0),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      difficulty.description,
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12.sp.clamp(11.0, 14.0),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(LucideIcons.trophy, color: color, size: 15.r),
                        SizedBox(width: 5.w),
                        Text(
                          AppStrings.bestScore(bestScore),
                          style: TextStyle(
                            color: color,
                            fontSize: 12.sp.clamp(11.0, 14.0),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(LucideIcons.chevronRight, color: color, size: 22.r),
            ],
          ),
        ),
      ),
    );
  }
}
