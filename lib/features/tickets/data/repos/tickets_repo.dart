import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

abstract class TicketsRepository {
  Future<Either<String, List<TicketModel>>> getAllTickets();
  Future<Either<String, Unit>> deleteTicket(String id);
  Future<Either<String, Unit>> deleteAllTickets();
}
