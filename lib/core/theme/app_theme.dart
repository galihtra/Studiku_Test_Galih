import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/resources/layout_app.dart';

abstract final class AppColors {
  static const deepNavy = Color(0xFF123A82);
  static const navy = Color(0xFF16325C);
  static const blue = Color(0xFF1769E0);
  static const cyan = Color(0xFF3BB8FF);
  static const sky = Color(0xFFE8F6FF);
  static const background = Color(0xFFF7FAFF);
  static const surface = Color(0xFFFFFFFF);
  static const muted = Color(0xFF6F809E);
  static const border = Color(0xFFDCE9F8);
  static const success = Color(0xFF35D69F);
  static const danger = Color(0xFFFF5D73);
  static const warning = Color(0xFFFFC83D);
  static const purple = Color(0xFFAA55E7);
  static const mint = Color(0xFFE5FBF4);

  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [blue, cyan],
  );

  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepNavy, blue],
  );
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.light,
      primary: AppColors.blue,
      secondary: AppColors.cyan,
      surface: AppColors.surface,
      error: AppColors.danger,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.navy,
          fontSize: 35.sp,
          height: 1.12,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.1,
        ),
        headlineMedium: TextStyle(
          color: AppColors.navy,
          fontSize: 27.sp,
          height: 1.2,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.7,
        ),
        titleLarge: TextStyle(
          color: AppColors.navy,
          fontSize: 20.sp,
          height: 1.3,
          fontWeight: FontWeight.w800,
        ),
        titleMedium: TextStyle(
          color: AppColors.navy,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          color: AppColors.navy,
          fontSize: 16.sp,
          height: 1.55,
        ),
        bodyMedium: TextStyle(
          color: AppColors.muted,
          fontSize: 14.sp,
          height: 1.5,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.navy,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: AppColors.navy,
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.cardRadius),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(AppLayout.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(AppLayout.buttonHeight),
          foregroundColor: AppColors.navy,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
