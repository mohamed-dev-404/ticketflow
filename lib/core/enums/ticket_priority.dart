import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';

part 'ticket_priority.g.dart';

@HiveType(typeId: 0)
enum TicketPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high;

  String get label {
    switch (this) {
      case TicketPriority.low:
        return 'Low';
      case TicketPriority.medium:
        return 'Medium';
      case TicketPriority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case TicketPriority.low:
        return AppColors.priorityLow;
      case TicketPriority.medium:
        return AppColors.priorityMedium;
      case TicketPriority.high:
        return AppColors.priorityHigh;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TicketPriority.low:
        return AppColors.priorityLowBg;
      case TicketPriority.medium:
        return AppColors.priorityMediumBg;
      case TicketPriority.high:
        return AppColors.priorityHighBg;
    }
  }

  IconData get icon {
    switch (this) {
      case TicketPriority.low:
        return Icons.arrow_downward_rounded;
      case TicketPriority.medium:
        return Icons.remove_rounded;
      case TicketPriority.high:
        return Icons.arrow_upward_rounded;
    }
  }
}
