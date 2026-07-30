import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';

///! ===================================================
///! TicketFormLocalDataSource
///! ===================================================
///* Handles write operations for ticket creation & editing.
///* Used by: TicketFormView (Add / Edit modes).
abstract class TicketFormLocalDataSource {
  /// Creates a new ticket in local storage
  Future<void> addTicket(TicketModel ticket);

  /// Updates an existing ticket in local storage
  Future<void> updateTicket(TicketModel ticket);

  /// Checks if a ticket with the given ID exists
  Future<bool> exists(String id);
}
