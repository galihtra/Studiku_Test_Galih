import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kalkumi/core/theme/kalkumi_assets.dart';
import 'package:kalkumi/core/theme/kalkumi_widgets.dart';
import 'package:kalkumi/features/quiz/logic/quiz_session_controller.dart';
import 'package:kalkumi/features/quiz/presentation/widgets/content_frame.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/strings_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizLoadError extends StatelessWidget {
  const QuizLoadError({required this.controller, super.key});
  final QuizSessionController controller;

  @override
  Widget build(BuildContext context) {
    return ContentFrame(
      padding: EdgeInsets.fromLTRB(
        AppLayout.pageInset,
        24.h,
        AppLayout.pageInset,
        AppLayout.pageBottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            KalkumiAssets.mascotFailed,
            height: 190.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 18.h),
          ShadAlert.destructive(
            icon: const Icon(LucideIcons.fileQuestionMark),
            title: const Text(AppStrings.quizLoadErrorTitle),
            description: Text(controller.loadError ?? 'Data soal tidak valid.'),
          ),
          SizedBox(height: 18.h),
          KalkumiPrimaryButton(
            keyValue: const Key('retry_questions_button'),
            label: AppStrings.retry,
            icon: LucideIcons.rotateCcw,
            onPressed: controller.retry,
          ),
          SizedBox(height: 10.h),
          ShadButton.outline(
            height: AppLayout.buttonHeight,
            onPressed: () => context.pop(),
            child: const Text(AppStrings.backToChooseLevel),
          ),
        ],
      ),
    );
  }
}
