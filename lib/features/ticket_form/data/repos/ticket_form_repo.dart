import 'package:dartz/dartz.dart';
import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';

abstract class TicketFormRepository {
  Future<Either<String, Unit>> addTicket(TicketModel ticket);
  Future<Either<String, Unit>> updateTicket(TicketModel ticket);
  Future<Either<String, bool>> exists(String id);
}
