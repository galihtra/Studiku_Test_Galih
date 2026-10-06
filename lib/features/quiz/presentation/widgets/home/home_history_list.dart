import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/logic/quiz_history_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/empty_history.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/home/history_tile.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeHistoryList extends StatefulWidget {
  const HomeHistoryList({super.key});

  @override
  State<HomeHistoryList> createState() => _HomeHistoryListState();
}

class _HomeHistoryListState extends State<HomeHistoryList> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizHistoryController>(
      builder: (context, history, _) {
        if (history.isLoading) {
          return const KalkumiSurfaceCard(
            child: ShadProgress(
              minHeight: 5,
              color: AppColors.blue,
              semanticsLabel: 'Memuat riwayat permainan',
            ),
          );
        }
        if (history.hasError) {
          return ShadAlert.destructive(
            key: const Key('history_error'),
            icon: const Icon(LucideIcons.history),
            title: const Text(AppStrings.historyLoadErrorTitle),
            description: Text(
              history.errorMessage ?? AppStrings.historyLoadErrorBody,
            ),
            bottom: Align(
              alignment: Alignment.centerLeft,
              child: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: history.load,
                child: const Text(AppStrings.retry),
              ),
            ),
          );
        }
        if (history.isEmpty) return const EmptyHistory();

        final totalPages =
            (history.entries.length + AppValues.homeHistoryPageSize - 1) ~/
            AppValues.homeHistoryPageSize;
        final currentPage = min(_currentPage, totalPages - 1);
        final startIndex = currentPage * AppValues.homeHistoryPageSize;
        final visibleEntries = history.entries
            .skip(startIndex)
            .take(AppValues.homeHistoryPageSize)
            .toList(growable: false);
        return Column(
          children: [
            for (var index = 0; index < visibleEntries.length; index++) ...[
              HistoryTile(
                entry: visibleEntries[index],
                showNewBadge: currentPage == 0 && index == 0,
              ),
              if (index != visibleEntries.length - 1) SizedBox(height: 10.h),
            ],
            if (totalPages > 1) ...[
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShadButton.outline(
                    key: const Key('history_previous_page'),
                    size: ShadButtonSize.sm,
                    leading: const Icon(LucideIcons.chevronLeft),
                    onPressed: currentPage > 0
                        ? () => setState(() => _currentPage = currentPage - 1)
                        : null,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      '${currentPage + 1} / $totalPages',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12.sp.clamp(11.0, 14.0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ShadButton.outline(
                    key: const Key('history_next_page'),
                    size: ShadButtonSize.sm,
                    leading: const Icon(LucideIcons.chevronRight),
                    onPressed: currentPage < totalPages - 1
                        ? () => setState(() => _currentPage = currentPage + 1)
                        : null,
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
