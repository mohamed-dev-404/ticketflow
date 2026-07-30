import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/dashboard/data/data_sources/dashboard_local_data_source.dart';

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
    final box = _hiveService.ticketsBox;
    return box.length;
  }

  @override
  Future<int> getCountByStatus(TicketStatus status) async {
    final box = _hiveService.ticketsBox;
    return box.values.where((ticket) => ticket.status == status).length;
  }

  @override
  Future<Map<TicketStatus, int>> getAllStatusCounts() async {
    final box = _hiveService.ticketsBox;
    final tickets = box.values;

    return {
      for (final status in TicketStatus.values)
        status: tickets.where((ticket) => ticket.status == status).length,
    };
  }
}
