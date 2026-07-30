import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:ticketflow/core/widgets/animated_loading_widget.dart';

/// AppDialogs
///
/// Utility class for showing styled dialogs consistently across the application.

class AppDialogs {
  AppDialogs._(); // Private constructor to prevent instantiation

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xdefefefe),
      builder: (context) => const AnimatedLoadingWidget(),
    );
  }

  /// ─────────────────────────────────────────────────────────────────────────
  /// [showAlertDialog] — A professional, versatile alert dialog.
  ///
  /// **Usage Examples:**
  ///
  /// ```dart
  ///?  1. Confirmation dialog (OK + Cancel):
  /// AppDialogs.showAlertDialog(
  ///   context,
  ///   title: 'Delete Account?',
  ///   subtitle: 'This action cannot be undone.',
  ///   icon: Icons.warning_amber_rounded,
  ///   iconColor: AppColors.warningNormal,
  ///   ok: 'Delete',
  ///   no: 'Cancel',
  ///   onTap: () { /* handle delete */ Navigator.pop(context); },
  /// );
  ///
  ///? 2. Success / info dialog (OK only):
  /// AppDialogs.showAlertDialog(
  ///   context,
  ///   title: 'Operation Complete',
  ///   icon: Icons.check_circle_outline_rounded,
  ///   iconColor: AppColors.successNormal,
  ///   ok: 'OK',
  ///   onTap: () => Navigator.pop(context),
  /// );
  ///
  ///? 3. Dismissible notice (Cancel only):
  /// AppDialogs.showAlertDialog(
  ///   context,
  ///   title: 'No internet connection',
  ///   subtitle: 'Please check your network settings.',
  ///   icon: Icons.wifi_off_rounded,
  ///   no: 'Dismiss',
  /// );
  ///
  ///? 4. Minimal (title only — tap outside to dismiss):
  /// AppDialogs.showAlertDialog(context, title: 'Saved!');
  /// ```
  /// ─────────────────────────────────────────────────────────────────────────
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? ok,
    String? no,
    IconData? icon,
    Color? iconColor,
    void Function()? onTap,
    void Function()? onNoTap,
  }) {
    // Resolve the icon color — defaults to secondary (teal).
    final resolvedIconColor = iconColor ?? AppColors.orange;

    showDialog(
      context: context,
      barrierColor: AppColors.navy.withValues(alpha: 0.45),
      builder: (BuildContext dialogContext) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightGray, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Icon ──
                  if (icon != null) ...[
                    Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: resolvedIconColor.withValues(alpha: 0.10),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 42, color: resolvedIconColor),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // ── Title ──
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppStyles.labelLarge.copyWith(
                      color: AppColors.navy,
                    ),
                  ),

                  // ── Subtitle ──
                  if (subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.gray,
                        height: 1.45,
                      ),
                    ),
                  ],

                  // ── Action Buttons ──
                  if (ok != null || no != null) ...[
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        // Cancel / secondary button (outlined)
                        if (no != null)
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: OutlinedButton(
                                onPressed:
                                    onNoTap ??
                                    () => Navigator.pop(dialogContext),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColors.lightGray,
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  no,
                                  style: AppStyles.buttonLarge.copyWith(
                                    color: AppColors.gray,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Spacer between buttons when both exist
                        if (ok != null && no != null) const SizedBox(width: 12),

                        // Confirm / primary button (filled)
                        if (ok != null)
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: ElevatedButton(
                                onPressed: onTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.navy,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  ok,
                                  style: AppStyles.buttonLarge.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
