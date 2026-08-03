import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';

class TicketStatusFilterChip extends StatelessWidget {
  const TicketStatusFilterChip({
    super.key,
    required this.selected,
    required this.onTap,
    this.status,
  });

  /// null = All
  final TicketStatus? status;

  final bool selected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = status?.color ?? AppColors.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: .1) : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: selected ? color : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (status == null) ...[
              Icon(Icons.check_rounded, size: 18, color: color),
              const SizedBox(width: 6),
            ] else ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
            ],

            Text(
              status?.label ?? 'All',
              style: AppStyles.medium14.copyWith(
                color: selected ? color : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
