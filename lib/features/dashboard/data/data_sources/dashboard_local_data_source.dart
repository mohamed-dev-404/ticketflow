import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/features/dashboard/data/models/ticket_statistics_model.dart';

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

  /// Returns the ticket statistics model containing total and status counts
  Future<TicketStatisticsModel> getAllStatusCounts();
}
