import 'package:ticketflow/core/enums/ticket_status.dart';

///! ===================================================
///! DashboardLocalDataSource
///! ===================================================
///* Handles aggregate/statistics operations for the dashboard.
///* Used by: DashboardWidget to display ticket counts.
abstract class DashboardLocalDataSource {
  /// Returns the total number of tickets
  Future<int> getTotalCount();

  /// Returns the count of tickets with a specific status
  Future<int> getCountByStatus(TicketStatus status);

  /// Returns a map of all statuses with their respective counts
  Future<Map<TicketStatus, int>> getAllStatusCounts();
}
