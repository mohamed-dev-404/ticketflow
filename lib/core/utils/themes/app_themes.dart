import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightTheme => ThemeData(
    //* core theme settings
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      // text color
      onSurface: AppColors.navy,
    ),

    //* AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      //  surfaceTintColor: Colors.transparent,
    ),

    //* Divider theme
    dividerColor: AppColors.lightGray,
    dividerTheme: const DividerThemeData(color: AppColors.lightGray),

    // * TextButton theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(60, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),

    //* Input decoration theme for styling of text fields
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppStyles.fields.copyWith(
        color: AppColors.gray,
      ),
      fillColor: AppColors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.navy,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.navy,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 1.5,
        ),
      ),
    ),

    //* BottomNavigationBar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.navy,
      unselectedItemColor: AppColors.gray,
      backgroundColor: AppColors.white,
      selectedLabelStyle: AppStyles.bodyMedium.copyWith(
        color: AppColors.gray,
      ),
      unselectedLabelStyle: AppStyles.bodyMedium.copyWith(
        color: AppColors.gray,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
  );
}
