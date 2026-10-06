import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/app/app_routes.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/history/history_centered_message.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HistoryNotFound extends StatelessWidget {
  const HistoryNotFound({super.key});

  @override
  Widget build(BuildContext context) => HistoryCenteredMessage(
    icon: LucideIcons.fileQuestionMark,
    title: AppStrings.historyNotFoundTitle,
    body: AppStrings.historyNotFoundBody,
    buttonLabel: AppStrings.backToHome,
    onPressed: () => context.go(AppRoutes.home),
  );
}
