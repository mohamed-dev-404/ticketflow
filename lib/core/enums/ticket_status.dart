import 'package:hive_ce/hive.dart';

part 'ticket_status.g.dart';

@HiveType(typeId: 2)
enum TicketStatus {
  @HiveField(0)
  open,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  closed,
}
