import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeScoreFeedback extends StatelessWidget {
  const HomeScoreFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreboardController>(
      builder: (context, scoreboard, _) {
        if (scoreboard.isLoading) {
          return Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: const ShadProgress(
              minHeight: 5,
              color: AppColors.blue,
              semanticsLabel: 'Memuat best score',
            ),
          );
        }
        if (!scoreboard.hasError) return const SizedBox.shrink();
        return Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: ShadAlert.destructive(
            icon: const Icon(LucideIcons.databaseZap),
            title: const Text('Data skor tidak tampil'),
            description: Text(scoreboard.errorMessage ?? 'Terjadi kesalahan.'),
            bottom: Align(
              alignment: Alignment.centerLeft,
              child: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: scoreboard.load,
                child: const Text(AppStrings.retry),
              ),
            ),
          ),
        );
      },
    );
  }
}
