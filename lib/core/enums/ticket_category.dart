import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:ticketflow/core/utils/colors/app_colors.dart';

part 'ticket_category.g.dart';

@HiveType(typeId: 1)
enum TicketCategory {
  @HiveField(0)
  technical,

  @HiveField(1)
  billing,

  @HiveField(2)
  general;

  String get label {
    switch (this) {
      case TicketCategory.technical:
        return 'Technical';
      case TicketCategory.billing:
        return 'Billing';
      case TicketCategory.general:
        return 'General';
    }
  }

  Color get color {
    switch (this) {
      case TicketCategory.technical:
        return AppColors.catTechnical;
      case TicketCategory.billing:
        return AppColors.catBilling;
      case TicketCategory.general:
        return AppColors.catGeneral;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case TicketCategory.technical:
        return AppColors.catTechnical.withValues(alpha: .12);
      case TicketCategory.billing:
        return AppColors.catBilling.withValues(alpha: .12);
      case TicketCategory.general:
        return AppColors.catGeneral.withValues(alpha: .12);
    }
  }

  IconData get icon {
    switch (this) {
      case TicketCategory.technical:
        return Icons.code_rounded;

      case TicketCategory.billing:
        return Icons.receipt_long_rounded;

      case TicketCategory.general:
        return Icons.dashboard_customize_rounded;
    }
  }

  String get prefix {
    switch (this) {
      case TicketCategory.technical:
        return 'TECH';
      case TicketCategory.billing:
        return 'BIL';
      case TicketCategory.general:
        return 'GEN';
    }
  }
}
