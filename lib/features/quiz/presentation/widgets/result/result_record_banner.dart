import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResultRecordBanner extends StatelessWidget {
  const ResultRecordBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF4C2), Color(0xFFFFE07A)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Image.asset(KalkumiAssets.trophy, width: 50.r, height: 50.r),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.resultRecordBannerTitle,
                  style: TextStyle(
                    color: AppColors.deepNavy,
                    fontSize: 12.sp.clamp(11.0, 14.0),
                    fontWeight: FontWeight.w900,
                    letterSpacing: .7,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.resultRecordBannerBody,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12.sp.clamp(11.0, 14.0),
                  ),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.trendingUp, color: AppColors.blue, size: 22.r),
        ],
      ),
    );
  }
}
