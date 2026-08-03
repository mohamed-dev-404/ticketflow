import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';

part 'ticket_status.g.dart';

@HiveType(typeId: 2)
enum TicketStatus {
  @HiveField(0)
  open,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  closed;

  String get label {
    switch (this) {
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.closed:
        return 'Closed';
    }
  }

  Color get color {
    switch (this) {
      case TicketStatus.open:
        return AppColors.statusOpen;
      case TicketStatus.inProgress:
        return AppColors.statusInProgress;
      case TicketStatus.closed:
        return AppColors.statusClosed;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TicketStatus.open:
        return AppColors.statusOpenBg;
      case TicketStatus.inProgress:
        return AppColors.statusInProgressBg;
      case TicketStatus.closed:
        return AppColors.statusClosedBg;
    }
  }

  IconData get icon {
    switch (this) {
      case TicketStatus.open:
        return Icons.radio_button_checked_rounded;
      case TicketStatus.inProgress:
        return Icons.hourglass_top_rounded;
      case TicketStatus.closed:
        return Icons.check_circle_rounded;
    }
  }
}
