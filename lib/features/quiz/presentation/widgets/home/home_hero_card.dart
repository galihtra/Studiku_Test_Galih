import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeHeroCard extends StatelessWidget {
  const HomeHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.heroHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x401769E0),
              blurRadius: 24,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Stack(
            children: [
              Positioned(
                right: -48.w,
                top: -75.h,
                child: Container(
                  width: 210.r,
                  height: 210.r,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .07),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 5.w,
                bottom: -9.h,
                child: Image.asset(
                  KalkumiAssets.mascotEncouraging,
                  width: 158.w.clamp(145.0, 175.0),
                  height: 188.h.clamp(170.0, 205.0),
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 20.w,
                top: 18.h,
                child: Icon(
                  LucideIcons.sparkles,
                  color: AppColors.warning,
                  size: 27.r,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  21.w.clamp(18.0, 27.0),
                  21.h,
                  142.w.clamp(132.0, 158.0),
                  21.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.homeHeroGreeting,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .82),
                        fontSize: 11.sp.clamp(10.0, 13.0),
                        fontWeight: FontWeight.w900,
                        letterSpacing: .7,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      AppStrings.homeHeroTitle,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27.sp.clamp(24.0, 30.0),
                        height: 1.12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -.8,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .14),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        '${AppValues.questionsPerSession} SOAL  •  ${AppValues.difficultyCount} LEVEL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp.clamp(9.0, 12.0),
                          fontWeight: FontWeight.w900,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
