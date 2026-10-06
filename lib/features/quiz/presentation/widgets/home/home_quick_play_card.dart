import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeQuickPlayCard extends StatelessWidget {
  const HomeQuickPlayCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('start_quiz_button'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(25.r),
        child: Ink(
          padding: EdgeInsets.all(17.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFCF48), Color(0xFFFFDF82)],
            ),
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(color: Colors.white, width: 2.w),
            boxShadow: const [
              BoxShadow(
                color: Color(0x38FFC83D),
                blurRadius: 18,
                offset: Offset(0, 9),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 67.r,
                height: 67.r,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .28),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.zap,
                  color: AppColors.deepNavy,
                  size: 32.r,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MULAI PETUALANGAN',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 10.sp.clamp(9.0, 12.0),
                        fontWeight: FontWeight.w900,
                        letterSpacing: .6,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      AppStrings.choosePower,
                      style: TextStyle(
                        color: AppColors.deepNavy,
                        fontSize: 19.sp.clamp(17.0, 22.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Easy • Medium • Hard',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12.sp.clamp(11.0, 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 52.r,
                height: 52.r,
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.play, color: Colors.white, size: 24.r),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
