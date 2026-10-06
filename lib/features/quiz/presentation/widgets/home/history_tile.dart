import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty_badge.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    required this.entry,
    this.showNewBadge = false,
    super.key,
  });

  final QuizHistoryEntry entry;
  final bool showNewBadge;

  @override
  Widget build(BuildContext context) {
    final color = entry.difficulty.color;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: Key('history_${entry.id}'),
        onTap: () => context.push(AppRoutes.historyDetail(entry.id)),
        borderRadius: BorderRadius.circular(AppLayout.cardRadius),
        child: Ink(
          padding: EdgeInsets.all(AppLayout.cardPadding),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .97),
            borderRadius: BorderRadius.circular(AppLayout.cardRadius),
            border: Border.all(color: color.withValues(alpha: .18)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D123A82),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: AppLayout.historyIconSize,
                height: AppLayout.historyIconSize,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  entry.difficulty.icon,
                  color: Colors.white,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 13.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          entry.difficulty.label,
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 15.sp.clamp(14.0, 17.0),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (showNewBadge) ...[
                          SizedBox(width: 7.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD84D),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                color: AppColors.deepNavy,
                                fontSize: 8.sp.clamp(8.0, 10.0),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      formatQuizDate(entry.completedAt),
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 11.sp.clamp(10.0, 13.0),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppStrings.scoreFraction(entry.score, entry.totalQuestions),
                    style: TextStyle(
                      color: color,
                      fontSize: 20.sp.clamp(18.0, 23.0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Text(
                      '${entry.accuracy}% akurasi',
                      style: TextStyle(
                        color: color,
                        fontSize: 9.sp.clamp(9.0, 11.0),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 5.w),
              Icon(
                LucideIcons.chevronRight,
                color: color.withValues(alpha: .42),
                size: 21.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatQuizDate(DateTime value) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  final local = value.toLocal();
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.day} ${months[local.month - 1]} ${local.year} • ${local.hour}:$minute';
}
