import 'package:flutter/material.dart';

/// Class containing all text styles defined in the design system.
abstract class AppStyles {
  // Main font family used across styles
  static const String _fontFamily = 'Cairo';

  /// taps - 11px Bold (used for taps only)
  static const TextStyle taps = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.bold, // w700
  );

  /// Bodylarge - 16px Regular
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal, // w400
  );

  /// Bodylarge_bold - 16px Bold
  static const TextStyle bodyLargeBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold, // w700
  );

  /// BodyMedium - 14px Regular
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal, // w400
  );

  /// BodySmall - 11px Regular
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.normal, // w400
  );

  /// ButtonLarge - 16px SemiBold/Bold
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600, // SemiBold
  );

  /// TitleLarge - 24px Bold
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold, // w700
  );

  /// TitleLarge_semibold - 24px SemiBold
  static const TextStyle titleLargeSemibold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600, // SemiBold
  );

  /// LabelLarge - 20px Medium
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500, // Medium
  );

  /// fields - 14px Regular
  static const TextStyle fields = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal, // w400
  );
}