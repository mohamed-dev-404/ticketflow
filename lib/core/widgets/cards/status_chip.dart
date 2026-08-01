import 'package:flutter/material.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';

class StatusChip extends StatelessWidget {
  final TicketStatus status;
  final bool compact;
  final bool showDecoration;

  const StatusChip({
    super.key,
    required this.status,
    this.compact = false,
    this.showDecoration = true,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = status.color;
    final bgColor = status.backgroundColor;

    return Container(
      padding: showDecoration
          ? EdgeInsets.symmetric(
              horizontal: compact ? 8.0 : 12.0,
              vertical: compact ? 4.0 : 6.0,
            )
          : EdgeInsets.zero,
      decoration: showDecoration
          ? BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(999),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: compact ? 12.0 : 14.0, color: fgColor),
          const SizedBox(width: 6.0),
          Text(
            status.label,
            style: TextStyle(
              color: fgColor,
              fontSize: compact ? 11.0 : 12.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
