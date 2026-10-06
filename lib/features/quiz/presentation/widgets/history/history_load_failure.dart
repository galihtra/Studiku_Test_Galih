import 'package:flutter/material.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_centered_message.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryLoadFailure extends StatelessWidget {
  const HistoryLoadFailure({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => HistoryCenteredMessage(
    icon: LucideIcons.databaseZap,
    title: AppStrings.historyLoadErrorTitle,
    body: AppStrings.historyLoadErrorBody,
    buttonLabel: AppStrings.retry,
    onPressed: onRetry,
  );
}
