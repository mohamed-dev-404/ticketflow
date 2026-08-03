import 'package:ticketflow/core/models/ticket_model.dart';

///! ===================================================
///! TicketLocalDataSource
///! ===================================================
///* Handles read & delete operations for the tickets feature.
///* Used by: TicketsList, TicketDetails views.
abstract class TicketLocalDataSource {
  /// Retrieves all stored tickets
  Future<List<TicketModel>> getAllTickets();

  /// Deletes a single ticket by its ID
  Future<void> deleteTicket(String id);

  /// Deletes all stored tickets
  Future<void> deleteAllTickets();
}
