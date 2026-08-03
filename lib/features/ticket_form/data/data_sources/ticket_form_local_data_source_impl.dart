import 'package:ticketflow/core/models/ticket_model.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source.dart';
import 'package:ticketflow/core/errors/exceptions/cache_exception.dart';
import 'package:ticketflow/core/errors/models/error_model.dart';
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
    try {
      final box = _hiveService.ticketsBox;
      await _hiveService.put(box, ticket.id, ticket);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to add ticket to local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> updateTicket(TicketModel ticket) async {
    try {
      final box = _hiveService.ticketsBox;
      if (_hiveService.containsKey(box, ticket.id)) {
        await _hiveService.put(box, ticket.id, ticket);
      } else {
        throw CacheException(
          errorModel: ErrorModel(
            errorMessage: 'Ticket with id ${ticket.id} does not exist in local storage.',
          ),
        );
      }
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to update ticket in local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<bool> exists(String id) async {
    try {
      final box = _hiveService.ticketsBox;
      return _hiveService.containsKey(box, id);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to check if ticket exists in local storage: ${e.toString()}',
        ),
      );
    }
  }
}
