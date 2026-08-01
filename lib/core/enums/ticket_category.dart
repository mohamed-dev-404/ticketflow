import 'package:hive_ce/hive.dart';

part 'ticket_category.g.dart';

@HiveType(typeId: 1)
enum TicketCategory {
  @HiveField(0)
  technical,
  @HiveField(1)
  billing,
  @HiveField(2)
  general;

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
}
