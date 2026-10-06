import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/features/quiz/domain/quiz_difficulty.dart';
import 'package:kalkumi/features/quiz/domain/quiz_result_args.dart';
import 'package:kalkumi/features/quiz/logic/quiz_session_controller.dart';
import 'package:kalkumi/features/quiz/presentation/screens/difficulty_screen.dart';
import 'package:kalkumi/features/quiz/presentation/screens/history_detail_screen.dart';
import 'package:kalkumi/features/quiz/presentation/screens/home_screen.dart';
import 'package:kalkumi/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:kalkumi/features/quiz/presentation/screens/result_screen.dart';
import 'package:kalkumi/features/quiz/presentation/screens/splash_screen.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';

GoRouter createAppRouter({
  String initialLocation = AppRoutes.splash,
}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
    GoRoute(path: AppRoutes.home, builder: (_, _) => const HomeScreen()),
    GoRoute(
      path: AppRoutes.difficulty,
      builder: (_, _) => const DifficultyScreen(),
    ),
    GoRoute(
      name: AppRoutes.quizName,
      path: AppRoutes.quizPattern,
      builder: (_, state) {
        final difficulty = QuizDifficulty.values
            .where((value) => value.name == state.pathParameters['difficulty'])
            .firstOrNull;
        if (difficulty == null) {
          return const _InvalidRouteScreen();
        }
        return ChangeNotifierProvider(
          create: (_) => QuizSessionController(difficulty: difficulty),
          child: QuizScreen(difficulty: difficulty),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.result,
      builder: (_, state) {
        final args = state.extra;
        return args is QuizResultArgs
            ? ResultScreen(args: args)
            : const _InvalidRouteScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.historyDetailName,
      path: AppRoutes.historyDetailPattern,
      builder: (_, state) =>
          HistoryDetailScreen(historyId: state.pathParameters['id'] ?? ''),
    ),
  ],
  errorBuilder: (_, _) => const _InvalidRouteScreen(),
);

class _InvalidRouteScreen extends StatelessWidget {
  const _InvalidRouteScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.route_outlined, size: 48),
              const SizedBox(height: 12),
              const Text(AppStrings.historyNotFoundTitle),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text(AppStrings.backToHome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
