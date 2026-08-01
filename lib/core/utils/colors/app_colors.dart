import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ===========================================================
  // BRAND - PRIMARY (INDIGO)
  // ===========================================================

  static const Color primary50 = Color(0xFFEEF2FF);
  static const Color primary100 = Color(0xFFE0E7FF);
  static const Color primary200 = Color(0xFFC7D2FE);
  static const Color primary300 = Color(0xFFA5B4FC);
  static const Color primary400 = Color(0xFF818CF8);
  static const Color primary500 = Color(0xFF6366F1);
  static const Color primary600 = Color(0xFF4F46E5);
  static const Color primary700 = Color(0xFF4338CA);
  static const Color primary800 = Color(0xFF3730A3);
  static const Color primary900 = Color(0xFF312E81);

  static const Color primary = primary600;
  static const Color primaryLight = primary400;
  static const Color primaryDark = primary700;
  static const Color primaryContainer = primary50;

  // ===========================================================
  // SECONDARY (ORANGE)
  // ===========================================================

  static const Color secondary50 = Color(0xFFFFF7ED);
  static const Color secondary100 = Color(0xFFFFEDD5);
  static const Color secondary200 = Color(0xFFFED7AA);
  static const Color secondary300 = Color(0xFFFDBA74);
  static const Color secondary400 = Color(0xFFFB923C);
  static const Color secondary500 = Color(0xFFF97316);
  static const Color secondary600 = Color(0xFFEA580C);
  static const Color secondary700 = Color(0xFFC2410C);
  static const Color secondary800 = Color(0xFF9A3412);
  static const Color secondary900 = Color(0xFF7C2D12);

  static const Color secondary = secondary500;
  static const Color secondaryContainer = secondary100;

  // ===========================================================
  // ACCENT
  // ===========================================================

  static const Color accent = Color(0xFF8B5CF6);

  // ===========================================================
  // NEUTRAL (SLATE)
  // ===========================================================

  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // ===========================================================
  // BACKGROUND
  // ===========================================================

  static const Color background = slate50;

  static const Color surface = Colors.white;

  static const Color card = Colors.white;

  static const Color divider = slate200;

  static const Color border = slate200;

  // ===========================================================
  // TEXT
  // ===========================================================

  static const Color textPrimary = slate900;

  static const Color textSecondary = slate600;

  static const Color textMuted = slate400;

  static const Color textDisabled = slate300;

  // ===========================================================
  // SUCCESS
  // ===========================================================

  static const Color success50 = Color(0xFFECFDF5);
  static const Color success100 = Color(0xFFD1FAE5);
  static const Color success500 = Color(0xFF10B981);
  static const Color success600 = Color(0xFF059669);

  static const Color success = success500;

  // ===========================================================
  // WARNING
  // ===========================================================

  static const Color warning50 = Color(0xFFFFFBEB);
  static const Color warning100 = Color(0xFFFEF3C7);
  static const Color warning500 = Color(0xFFF59E0B);
  static const Color warning600 = Color(0xFFD97706);

  static const Color warning = warning500;

  // ===========================================================
  // ERROR
  // ===========================================================

  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFDC2626);

  static const Color error = error500;

  // ===========================================================
  // INFO
  // ===========================================================

  static const Color info50 = Color(0xFFEFF6FF);
  static const Color info100 = Color(0xFFDBEAFE);
  static const Color info500 = Color(0xFF3B82F6);
  static const Color info600 = Color(0xFF2563EB);

  static const Color info = info500;

  // ===========================================================
  // TICKET STATUS
  // ===========================================================

  static const Color statusOpen = info600;
  static const Color statusOpenBg = info50;

  static const Color statusInProgress = warning600;
  static const Color statusInProgressBg = warning50;

  static const Color statusClosed = success600;
  static const Color statusClosedBg = success50;

  // ===========================================================
  // PRIORITY
  // ===========================================================

  static const Color priorityLow = success500;
  static const Color priorityLowBg = success50;

  static const Color priorityMedium = warning500;
  static const Color priorityMediumBg = warning50;

  static const Color priorityHigh = error500;
  static const Color priorityHighBg = error50;

  // ===========================================================
  // CATEGORY
  // ===========================================================

  static const Color catTechnical = primary;

  static const Color catBilling = secondary;

  static const Color catGeneral = Color(0xFF14B8A6);

  // ===========================================================
  // LOADING
  // ===========================================================

  static const Color skeletonBase = slate200;

  static const Color skeletonHighlight = slate100;

  // ===========================================================
  // SHADOWS
  // ===========================================================

  static const Color shadow = Color(0x14000000);

  static const Color overlay = Color(0x80000000);
}
