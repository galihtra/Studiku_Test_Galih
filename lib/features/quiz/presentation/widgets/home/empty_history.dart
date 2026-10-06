import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return KalkumiSurfaceCard(
      child: Row(
        children: [
          Container(
            width: AppLayout.historyIconSize,
            height: AppLayout.historyIconSize,
            decoration: BoxDecoration(
              color: AppColors.sky,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(LucideIcons.trophy, color: AppColors.blue, size: 25.r),
          ),
          SizedBox(width: 13.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.historyEmptyTitle,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 15.sp.clamp(14.0, 17.0),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  AppStrings.historyEmptyBody,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12.sp.clamp(11.0, 14.0),
                    height: 1.4,
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
