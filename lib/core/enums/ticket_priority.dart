import 'package:hive_ce/hive.dart';

part 'ticket_priority.g.dart';

@HiveType(typeId: 0)
enum TicketPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}
