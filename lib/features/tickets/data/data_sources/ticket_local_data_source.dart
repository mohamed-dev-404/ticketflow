import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';

///! ===================================================
///! TicketLocalDataSource
///! ===================================================
///* Handles read & delete operations for the tickets feature.
///* Used by: TicketsList, TicketDetails views.
abstract class TicketLocalDataSource {
  /// Retrieves all stored tickets
  Future<List<TicketModel>> getAllTickets();

  /// Retrieves a single ticket by its ID
  Future<TicketModel?> getTicketById(String id);

  /// Deletes a single ticket by its ID
  Future<void> deleteTicket(String id);

  /// Deletes all stored tickets
  Future<void> deleteAllTickets();
}
