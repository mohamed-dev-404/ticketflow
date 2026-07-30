import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/tickets/data/data_sources/ticket_local_data_source.dart';

///! ===================================================
///! TicketLocalDataSourceImpl
///! ===================================================
///* Implementation of [TicketLocalDataSource].
///* Delegates all persistence operations to [HiveService] generic helpers.
class TicketLocalDataSourceImpl implements TicketLocalDataSource {
  final HiveService _hiveService;

  TicketLocalDataSourceImpl(this._hiveService);

  @override
  Future<List<TicketModel>> getAllTickets() async {
    final box = _hiveService.ticketsBox;
    return _hiveService.getAll(box);
  }

  @override
  Future<TicketModel?> getTicketById(String id) async {
    final box = _hiveService.ticketsBox;
    return _hiveService.get(box, id);
  }

  @override
  Future<void> deleteTicket(String id) async {
    final box = _hiveService.ticketsBox;
    await _hiveService.delete(box, id);
  }

  @override
  Future<void> deleteAllTickets() async {
    final box = _hiveService.ticketsBox;
    await _hiveService.clear(box);
  }
}
