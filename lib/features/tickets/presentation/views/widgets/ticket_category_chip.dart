import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_category.dart';
import 'package:ticketflow/core/utils/styles/app_styles.dart';

class TicketCategoryChip extends StatelessWidget {
  const TicketCategoryChip({super.key, required this.category});

  final TicketCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, size: 14, color: category.color),
          const SizedBox(width: 6),
          Text(
            category.label,
            style: AppStyles.bold12.copyWith(
              color: category.color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
