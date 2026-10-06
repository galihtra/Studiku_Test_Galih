import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/domain/quiz_history_entry.dart';
import 'package:kalkumi/features/quiz/domain/quiz_result_args.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/logic/result_persistence_controller.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/content_frame.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/difficulty_badge.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/result/result_hero.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/result/result_performance_card.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/result/result_record_banner.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({required this.args, super.key});

  final QuizResultArgs args;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final ResultPersistenceController _persistenceController;

  QuizHistoryEntry get _entry => widget.args.entry;

  @override
  void initState() {
    super.initState();
    _persistenceController = ResultPersistenceController(
      entry: _entry,
      scoreboard: context.read<ScoreboardController>(),
      history: context.read<QuizHistoryController>(),
      persistenceFailed: widget.args.persistenceFailed,
    );
  }

  @override
  void dispose() {
    _persistenceController.dispose();
    super.dispose();
  }

  String get _headline => switch (_entry.score) {
    >= 9 => 'Math superstar!',
    >= 7 => 'Ritmemu keren!',
    >= 5 => 'Makin kuat!',
    _ => 'Terus berlatih!',
  };

  String get _message => switch (_entry.score) {
    >= 9 => 'Fokusmu luar biasa. Skor sempurna sudah dekat!',
    >= 7 => 'Fondasinya kuat. Coba lagi untuk pecahkan rekor.',
    >= 5 => 'Setiap jawaban sedang membangun math power-mu.',
    _ =>
      'Setiap jagoan mulai dari latihan. Sesi berikutnya adalah peluang baru!',
  };

  Color get _accentColor => switch (_entry.score) {
    >= 8 => AppColors.success,
    >= 5 => AppColors.blue,
    _ => AppColors.deepNavy,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KalkumiBackdrop(
        child: SafeArea(
          child: ListenableBuilder(
            listenable: _persistenceController,
            builder: (context, _) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ContentFrame(
                      padding: AppLayout.pagePadding.copyWith(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                'HASIL PETUALANGAN',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 11.sp.clamp(10.0, 13.0),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                              const Spacer(),
                              DifficultyBadge(difficulty: _entry.difficulty),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          if (_persistenceController.isNewBest) ...[
                            const ResultRecordBanner(),
                            SizedBox(height: 14.h),
                          ],
                          if (_persistenceController.persistenceFailed) ...[
                            ShadAlert.destructive(
                              key: const Key('persistence_error'),
                              icon: const Icon(LucideIcons.saveOff),
                              title: const Text('Hasil belum tersimpan'),
                              description: const Text(
                                AppStrings.localStorageError,
                              ),
                              bottom: Align(
                                alignment: Alignment.centerLeft,
                                child: ShadButton.outline(
                                  size: ShadButtonSize.sm,
                                  enabled: !_persistenceController.retrying,
                                  onPressed: _persistenceController.retrying
                                      ? null
                                      : _persistenceController.retry,
                                  child: Text(
                                    _persistenceController.retrying
                                        ? 'Menyimpan...'
                                        : 'Coba simpan lagi',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                          ],
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              boxShadow: [
                                BoxShadow(
                                  color: _accentColor.withValues(alpha: .28),
                                  blurRadius: 22,
                                  offset: const Offset(0, 11),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ResultHero(
                                  score: _entry.score,
                                  headline: _headline,
                                  message: _message,
                                  accentColor: _accentColor,
                                ),
                                ResultPerformanceCard(
                                  score: _entry.score,
                                  bestScore: _persistenceController.bestScore,
                                  accentColor: _accentColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: ContentFrame(
                      padding: EdgeInsets.fromLTRB(
                        AppLayout.pagePadding.horizontal / 2,
                        0,
                        AppLayout.pagePadding.horizontal / 2,
                        AppLayout.pagePadding.bottom,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          KalkumiPrimaryButton(
                            keyValue: const Key('play_again_button'),
                            label: AppStrings.playAgain,
                            icon: LucideIcons.rotateCcw,
                            onPressed: () => context.pushReplacement(
                              AppRoutes.quiz(_entry.difficulty),
                            ),
                          ),
                          SizedBox(height: 11.h),
                          ShadButton.outline(
                            width: double.infinity,
                            height: AppLayout.buttonHeight,
                            onPressed: () => context.go(AppRoutes.home),
                            leading: const Icon(LucideIcons.home),
                            child: const Text(AppStrings.backToHome),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
