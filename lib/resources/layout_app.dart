import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/resources/values_app.dart';

abstract final class AppLayout {
  static double get pageInset => 18.w.clamp(14.0, 28.0);
  static double get pageTop => 14.h.clamp(10.0, 20.0);
  static double get pageBottom => 32.h.clamp(24.0, 44.0);
  static double get sectionGap => 26.h.clamp(20.0, 34.0);
  static double get itemGap => 12.w.clamp(10.0, 18.0);
  static double get cardPadding => 16.r.clamp(14.0, 20.0);
  static double get cardRadius => 24.r.clamp(20.0, 30.0);
  static double get buttonHeight => 56.h.clamp(52.0, 62.0);
  static double get iconSize => 24.r.clamp(21.0, 29.0);
  static double get historyIconSize => 48.r.clamp(44.0, 56.0);
  static double get heroHeight => 236.h.clamp(218.0, 270.0);

  static EdgeInsets get pagePadding =>
      EdgeInsets.fromLTRB(pageInset, pageTop, pageInset, pageBottom);

  static BoxConstraints get contentConstraints =>
      const BoxConstraints(maxWidth: AppValues.contentMaxWidth);
}
