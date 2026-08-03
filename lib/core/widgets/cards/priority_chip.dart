import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_priority.dart';

class PriorityChip extends StatelessWidget {
  final TicketPriority priority;
  final bool compact;
  final bool showDecoration;

  const PriorityChip({
    super.key,
    required this.priority,
    this.compact = false,
    this.showDecoration = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = priority.color;

    return Container(
      padding: showDecoration
          ? EdgeInsets.symmetric(
              horizontal: compact ? 8.0 : 10.0,
              vertical: compact ? 3.0 : 5.0,
            )
          : EdgeInsets.zero,
      decoration: showDecoration
          ? BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.0,
              ),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 6.0 : 8.0,
            height: compact ? 6.0 : 8.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6.0),
          Text(
            '${priority.label} Priority',
            style: TextStyle(
              color: color,
              fontSize: compact ? 11.0 : 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
