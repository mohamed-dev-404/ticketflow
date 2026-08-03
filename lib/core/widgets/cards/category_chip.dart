import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_category.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';

class CategoryChip extends StatelessWidget {
  final TicketCategory category;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.slate100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.slate200,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            const Icon(
              Icons.check,
              size: 16.0,
              color: Colors.white,
            ),
            const SizedBox(width: 6.0),
          ],
          Text(
            category.label,
            style: AppStyles.medium14.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
