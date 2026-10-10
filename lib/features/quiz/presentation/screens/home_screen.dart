import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/content_frame.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_brand_header.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_hero_card.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_history_list.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_quick_play_card.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_score_feedback.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_score_stats.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/home_section_header.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KalkumiBackdrop(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ContentFrame(
              padding: AppLayout.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeBrandHeader(),
                  SizedBox(height: 18.h),
                  const HomeHeroCard(),
                  SizedBox(height: 18.h),
                  HomeQuickPlayCard(
                    onTap: () => context.push(AppRoutes.difficulty),
                  ),
                  const HomeScoreFeedback(),
                  SizedBox(height: AppLayout.sectionGap),
                  const HomeSectionHeader(
                    title: AppStrings.journeyTitle,
                    subtitle: AppStrings.journeySubtitle,
                  ),
                  SizedBox(height: 12.h),
                  const HomeScoreStats(),
                  SizedBox(height: AppLayout.sectionGap),
                  const HomeSectionHeader(
                    title: AppStrings.historyTitle,
                    subtitle: AppStrings.historySubtitle,
                  ),
                  SizedBox(height: 12.h),
                  const HomeHistoryList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
