import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source.dart';

///! ===================================================
///! TicketFormLocalDataSourceImpl
///! ===================================================
///* Implementation of [TicketFormLocalDataSource].
///* Delegates all persistence operations to [HiveService] generic helpers.
class TicketFormLocalDataSourceImpl implements TicketFormLocalDataSource {
  final HiveService _hiveService;

  TicketFormLocalDataSourceImpl(this._hiveService);

  @override
  Future<void> addTicket(TicketModel ticket) async {
    final box = _hiveService.ticketsBox;
    await _hiveService.put(box, ticket.id, ticket);
  }

  @override
  Future<void> updateTicket(TicketModel ticket) async {
    final box = _hiveService.ticketsBox;
    if (_hiveService.containsKey(box, ticket.id)) {
      await _hiveService.put(box, ticket.id, ticket);
    } else {
      throw Exception(
        'Ticket with id ${ticket.id} does not exist in local storage.',
      );
    }
  }

  @override
  Future<bool> exists(String id) async {
    final box = _hiveService.ticketsBox;
    return _hiveService.containsKey(box, id);
  }
}
