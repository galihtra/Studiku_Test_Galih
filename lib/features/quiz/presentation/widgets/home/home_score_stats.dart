import 'package:flutter/material.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_stat_card.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:provider/provider.dart';

class HomeScoreStats extends StatelessWidget {
  const HomeScoreStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreboardController>(
      builder: (context, scoreboard, _) => Row(
        children: [
          Expanded(
            child: HomeStatCard(
              imageAsset: KalkumiAssets.trophy,
              iconBackground: const Color(0xFFFFF6D8),
              value: AppStrings.scoreFraction(
                scoreboard.bestOverall,
                AppValues.questionsPerSession,
              ),
              label: 'Skor terbaik',
            ),
          ),
          SizedBox(width: AppLayout.itemGap),
          Expanded(
            child: HomeStatCard(
              imageAsset: KalkumiAssets.progress3d,
              iconBackground: AppColors.mint,
              value: '${scoreboard.playedLevels}/${AppValues.difficultyCount}',
              label: 'Level dicoba',
            ),
          ),
        ],
      ),
    );
  }
}
