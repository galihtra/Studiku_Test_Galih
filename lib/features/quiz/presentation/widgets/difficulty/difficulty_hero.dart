import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DifficultyHero extends StatelessWidget {
  const DifficultyHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h.clamp(168.0, 205.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x331769E0),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35.w,
            top: -65.h,
            child: Container(
              width: 185.r,
              height: 185.r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .09),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 12.w,
            bottom: -8.h,
            child: Image.asset(
              KalkumiAssets.mascotStudying,
              width: 144.r,
              height: 144.r,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 14.h,
            right: 17.w,
            child: Icon(
              LucideIcons.sparkles,
              color: AppColors.warning,
              size: 25.r,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              22.h,
              140.w.clamp(125.0, 155.0),
              20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.difficultyHeroEyebrow,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .8),
                    fontSize: 11.sp.clamp(10.0, 13.0),
                    fontWeight: FontWeight.w900,
                    letterSpacing: .8,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.difficultyHeroTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp.clamp(22.0, 28.0),
                    height: 1.13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.difficultyHeroSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .86),
                    fontSize: 12.sp.clamp(11.0, 14.0),
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
