import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

abstract class SearchRepository {
  Future<Either<String, List<TicketModel>>> searchBySubject(String query);
  Future<Either<String, List<TicketModel>>> getTicketsByStatus(
    TicketStatus status,
  );
  Future<Either<String, List<TicketModel>>> searchTickets({
    String? subject,
    TicketStatus? status,
  });
}
