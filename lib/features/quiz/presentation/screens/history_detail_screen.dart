import 'package:flutter/material.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_load_failure.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_not_found.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_result_view.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryDetailScreen extends StatelessWidget {
  const HistoryDetailScreen({required this.historyId, super.key});

  final String historyId;

  @override
  Widget build(BuildContext context) {
    final history = context.watch<QuizHistoryController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text(AppStrings.historyDetailAppBarTitle), centerTitle: true),
      body: KalkumiBackdrop(
        child: SafeArea(
          child: Builder(
            builder: (context) {
              if (history.isLoading) {
                return const Center(
                  child: ShadProgress(
                    minHeight: 5,
                    color: AppColors.blue,
                    semanticsLabel: 'Memuat detail hasil',
                  ),
                );
              }
              if (history.hasError) {
                return HistoryLoadFailure(onRetry: history.load);
              }
              final entry = history.findById(historyId);
              if (entry == null) return const HistoryNotFound();
              return HistoryResultView(entry: entry);
            },
          ),
        ),
      ),
    );
  }
}
