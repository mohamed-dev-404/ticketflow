import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/errors/exceptions/cache_exception.dart';
import 'package:ticketflow/core/errors/models/error_model.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:ticketflow/features/dashboard/data/models/ticket_statistics_model.dart';

///! ===================================================
///! DashboardLocalDataSourceImpl
///! ===================================================
///* Implementation of [DashboardLocalDataSource].
///* Reads from the tickets box via [HiveService] to compute statistics.
class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final HiveService _hiveService;

  DashboardLocalDataSourceImpl(this._hiveService);

  @override
  Future<int> getTotalCount() async {
    try {
      final box = _hiveService.ticketsBox;
      return box.length;
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage:
              'Failed to get total tickets count from local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<int> getCountByStatus(TicketStatus status) async {
    try {
      final box = _hiveService.ticketsBox;
      return box.values.where((ticket) => ticket.status == status).length;
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage:
              'Failed to get ticket count by status from local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<TicketStatisticsModel> getAllStatusCounts() async {
    try {
      final box = _hiveService.ticketsBox;
      final tickets = box.values;

      int openCount = 0;
      int inProgressCount = 0;
      int closedCount = 0;

      for (final ticket in tickets) {
        switch (ticket.status) {
          case TicketStatus.open:
            openCount++;
            break;
          case TicketStatus.inProgress:
            inProgressCount++;
            break;
          case TicketStatus.closed:
            closedCount++;
            break;
        }
      }

      return TicketStatisticsModel(
        totalTickets: tickets.length,
        openTickets: openCount,
        inProgressTickets: inProgressCount,
        closedTickets: closedCount,
      );
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage:
              'Failed to get ticket statistics from local storage: ${e.toString()}',
        ),
      );
    }
  }
}
