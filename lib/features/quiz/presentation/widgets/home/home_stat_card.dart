import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';

class HomeStatCard extends StatelessWidget {
  const HomeStatCard({
    this.icon,
    required this.iconBackground,
    this.imageAsset,
    required this.value,
    required this.label,
    super.key,
  }) : assert(
         icon != null || imageAsset != null,
         'Either icon or imageAsset must be provided',
       );

  final IconData? icon;
  final Color iconBackground;
  final String? imageAsset;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return KalkumiSurfaceCard(
      padding: EdgeInsets.all(15.r),
      child: Row(
        children: [
          Container(
            width: 43.r,
            height: 43.r,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: imageAsset != null
                ? Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Image.asset(imageAsset!, fit: BoxFit.contain),
                  )
                : Icon(icon, size: 22.r),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 20.sp.clamp(18.0, 23.0),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11.sp.clamp(10.0, 13.0),
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
