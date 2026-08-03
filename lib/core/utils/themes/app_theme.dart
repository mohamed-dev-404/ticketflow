import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/themes/app_radius.dart';
import 'package:ticketflow/core/utils/themes/app_spacing.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.divider,
      appBarTheme: CustomAppBarTheme.lightTheme,
      elevatedButtonTheme: CustomButtonTheme.lightElevated,
      inputDecorationTheme: CustomInputTheme.lightTheme,
      chipTheme: CustomChipTheme.lightTheme,
      cardTheme: CustomCardTheme.lightTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    );
  }
}

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static AppBarTheme get lightTheme => const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    scrolledUnderElevation: 0.5,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    actionsIconTheme: IconThemeData(color: AppColors.textPrimary),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class CustomButtonTheme {
  CustomButtonTheme._();
  static ElevatedButtonThemeData get lightElevated => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
      textStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  );
}

class CustomCardTheme {
  CustomCardTheme._();
  static CardThemeData get lightTheme => const CardThemeData(
    color: AppColors.card,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.borderLg,
      side: BorderSide(color: AppColors.slate200, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
  );
}

class CustomChipTheme {
  CustomChipTheme._();
  static ChipThemeData get lightTheme => const ChipThemeData(
    backgroundColor: AppColors.slate100,
    disabledColor: AppColors.slate200,
    selectedColor: AppColors.primaryContainer,
    secondarySelectedColor: AppColors.primary,
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xxs,
    ),
    labelStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    ),
    secondaryLabelStyle: TextStyle(
      color: AppColors.primary,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
    ),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.borderPill,
      side: BorderSide(color: AppColors.slate200),
    ),
  );
}

class CustomInputTheme {
  CustomInputTheme._();
  static InputDecorationTheme get lightTheme => const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.slate50,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    hintStyle: TextStyle(color: AppColors.slate400, fontSize: 14.0),
    labelStyle: TextStyle(
      color: AppColors.slate600,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.slate200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.slate200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.primary, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: AppRadius.borderMd,
      borderSide: BorderSide(color: AppColors.error, width: 2.0),
    ),
    errorStyle: TextStyle(
      color: AppColors.error,
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
    ),
  );
}
