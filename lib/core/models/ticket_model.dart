import 'package:hive_ce/hive.dart';
import 'package:ticketflow/core/enums/ticket_category.dart';
import 'package:ticketflow/core/enums/ticket_priority.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';

part 'ticket_model.g.dart';

@HiveType(typeId: 3)
class TicketModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String ticketNumber;

  @HiveField(2)
  final String subject;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final TicketPriority priority;

  @HiveField(5)
  final TicketCategory category;

  @HiveField(6)
  final TicketStatus status;

  @HiveField(7)
  final DateTime createdAt;

  TicketModel({
    required this.id,
    required this.ticketNumber,
    required this.subject,
    required this.description,
    required this.priority,
    required this.category,
    required this.status,
    required this.createdAt,
  });

  TicketModel copyWith({
    String? id,
    String? ticketNumber,
    String? subject,
    String? description,
    TicketPriority? priority,
    TicketCategory? category,
    TicketStatus? status,
    DateTime? createdAt,
  }) {
    return TicketModel(
      id: id ?? this.id,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
