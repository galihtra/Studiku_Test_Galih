import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/resources/values_app.dart';

class GradientProgress extends StatelessWidget {
  const GradientProgress({required this.value, super.key});

  final double value;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Progress quiz',
    value: '${(value * 100).round()}%',
    child: LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 9.h,
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(100.r),
        ),
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: AppValues.primaryAnimation,
          width: constraints.maxWidth * value.clamp(0, 1),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
      ),
    ),
  );
}
