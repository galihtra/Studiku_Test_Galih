import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';

class HomeBrandHeader extends StatelessWidget {
  const HomeBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final streak = context.select<QuizHistoryController, int>(
      (controller) => controller.currentStreak,
    );
    return Row(
      children: [
        Image.asset(
          KalkumiAssets.brandLogo,
          width: 146.w.clamp(136.0, 168.0),
          height: 49.h.clamp(44.0, 56.0),
          alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
          semanticLabel: AppStrings.appName,
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 11.w.clamp(9.0, 14.0),
            vertical: 8.h.clamp(7.0, 10.0),
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF5D4), Color(0xFFFFE89A)],
            ),
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(color: AppColors.warning.withValues(alpha: .35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                KalkumiAssets.streak3d,
                width: 20.r,
                height: 20.r,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 6.w),
              Text(
                '$streak DAY',
                style: TextStyle(
                  color: AppColors.deepNavy,
                  fontSize: 10.sp.clamp(9.0, 12.0),
                  fontWeight: FontWeight.w900,
                  letterSpacing: .6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
