import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/content_frame.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty/difficulty_card.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty/difficulty_hero.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreboard = context.watch<ScoreboardController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(AppStrings.chooseLevel),
        centerTitle: true,
      ),
      body: KalkumiBackdrop(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ContentFrame(
              padding: EdgeInsets.fromLTRB(
                AppLayout.pageInset,
                10.h,
                AppLayout.pageInset,
                AppLayout.pageBottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DifficultyHero(),
                  if (scoreboard.isLoading) ...[
                    SizedBox(height: 16.h),
                    const ShadProgress(
                      minHeight: 5,
                      color: AppColors.blue,
                      semanticsLabel: AppStrings.loadingBestScore,
                    ),
                  ],
                  if (scoreboard.hasError) ...[
                    SizedBox(height: 16.h),
                    ShadAlert.destructive(
                      icon: const Icon(LucideIcons.databaseZap),
                      title: const Text(AppStrings.bestScoreErrorTitle),
                      description: const Text(AppStrings.bestScoreErrorBody),
                      bottom: Align(
                        alignment: Alignment.centerLeft,
                        child: ShadButton.outline(
                          size: ShadButtonSize.sm,
                          onPressed: scoreboard.load,
                          child: const Text(AppStrings.reload),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 25.h),
                  Text(
                    AppStrings.choosePower,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    AppStrings.difficultyHeroDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 15.h),
                  for (final difficulty in QuizDifficulty.values) ...[
                    DifficultyCard(
                      difficulty: difficulty,
                      bestScore: scoreboard.bestFor(difficulty),
                      onTap: () => context.push(AppRoutes.quiz(difficulty)),
                    ),
                    SizedBox(height: 13.h),
                  ],
                  SizedBox(height: 4.h),
                  KalkumiSurfaceCard(
                    padding: EdgeInsets.all(15.r),
                    borderColor: AppColors.warning.withValues(alpha: .22),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 21.r,
                          backgroundColor: const Color(0xFFFFF6D8),
                          child: Icon(
                            LucideIcons.lightbulb,
                            color: const Color(0xFFF0A800),
                            size: 22.r,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            AppStrings.difficultyInfo,
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 13.sp.clamp(12.0, 15.0),
                              height: 1.4,
                              fontWeight: FontWeight.w700,
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
        ),
      ),
    );
  }
}
