import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

///! ===================================================
///! SearchLocalDataSource
///! ===================================================
///* Handles search & filter operations for the search feature.
///* Used by: Search view.
abstract class SearchLocalDataSource {
  /// Searches tickets by subject (case-insensitive partial match)
  Future<List<TicketModel>> searchBySubject(String query);

  /// Retrieves tickets filtered by a specific status
  Future<List<TicketModel>> getTicketsByStatus(TicketStatus status);

  /// Searches tickets with optional combined filters
  Future<List<TicketModel>> searchTickets({
    String? subject,
    TicketStatus? status,
  });
}
