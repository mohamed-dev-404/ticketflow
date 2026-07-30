import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.navy,
    this.borderColor,
    this.minWidth = double.infinity,
    this.minHeight = 41,
    this.textColor = AppColors.white,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color? borderColor;
  final double minWidth;
  final double minHeight;
  final Color textColor;

  /// When true the button shows a spinner and ignores taps.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        disabledBackgroundColor: bgColor,
        padding: EdgeInsets.zero,
        maximumSize: Size(minWidth, minHeight),
        minimumSize: Size(minWidth, minHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: textColor,
              ),
            )
          //todo: text hint style
          : Text(
              text,
              style: AppStyles.buttonLarge.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
