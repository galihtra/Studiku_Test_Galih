import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';

class ResultMetricItem extends StatelessWidget {
  const ResultMetricItem({
    required this.value,
    required this.label,
    required this.color,
    super.key,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: TextStyle(
          color: color,
          fontSize: 21.sp.clamp(19.0, 24.0),
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(height: 2.h),
      Text(
        label,
        style: TextStyle(
          color: AppColors.muted,
          fontSize: 11.sp.clamp(10.0, 13.0),
        ),
      ),
    ],
  );
}
