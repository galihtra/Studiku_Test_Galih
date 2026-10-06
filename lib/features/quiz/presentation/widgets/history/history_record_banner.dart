import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';

class HistoryRecordBanner extends StatelessWidget {
  const HistoryRecordBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return KalkumiSurfaceCard(
      borderColor: AppColors.warning.withValues(alpha: .4),
      child: Row(
        children: [
          Image.asset(KalkumiAssets.trophy, width: 48.r, height: 48.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Sesi ini mencetak rekor baru!',
              style: TextStyle(
                color: AppColors.deepNavy,
                fontSize: 14.sp.clamp(13.0, 16.0),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
