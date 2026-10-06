import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/features/quiz/data/best_score_repository.dart';
import 'package:kalkumi/features/quiz/data/quiz_history_repository.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/logic/scoreboard_controller.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KalkumiApp extends StatefulWidget {
  const KalkumiApp({
    required this.scoreRepository,
    this.historyRepository,
    this.initialLocation = AppRoutes.splash,
    super.key,
  });

  final BestScoreRepository scoreRepository;
  final QuizHistoryRepository? historyRepository;
  final String initialLocation;

  @override
  State<KalkumiApp> createState() => _KalkumiAppState();
}

class _KalkumiAppState extends State<KalkumiApp> {
  late final GoRouter _router = createAppRouter(
    initialLocation: widget.initialLocation,
  );
  late final QuizHistoryRepository _historyRepository =
      widget.historyRepository ?? SharedPreferencesQuizHistoryRepository();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BestScoreRepository>.value(value: widget.scoreRepository),
        Provider<QuizHistoryRepository>.value(value: _historyRepository),
        ChangeNotifierProvider(
          create: (_) => ScoreboardController(widget.scoreRepository)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuizHistoryController(_historyRepository)..load(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: AppValues.designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => ShadApp.router(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: const ShadBlueColorScheme.light(
              background: AppColors.background,
              foreground: AppColors.navy,
              primary: AppColors.blue,
              border: AppColors.border,
              mutedForeground: AppColors.muted,
            ),
            radius: BorderRadius.circular(18.r),
          ),
          materialThemeBuilder: (_, materialTheme) => AppTheme.light,
          builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: AppColors.background,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: child!,
          ),
        ),
      ),
    );
  }
}
