import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/tickets/data/data_sources/ticket_local_data_source.dart';
import 'package:ticketflow/core/errors/exceptions/cache_exception.dart';
import 'package:ticketflow/core/errors/models/error_model.dart';

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
    try {
      final box = _hiveService.ticketsBox;
      return _hiveService.getAll(box);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to retrieve tickets from local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> deleteTicket(String id) async {
    try {
      final box = _hiveService.ticketsBox;
      if (_hiveService.containsKey(box, id)) {
        await _hiveService.delete(box, id);
      } else {
        throw CacheException(
          errorModel: ErrorModel(
            errorMessage: 'Ticket with id $id does not exist in local storage.',
          ),
        );
      }
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to delete ticket from local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> deleteAllTickets() async {
    try {
      final box = _hiveService.ticketsBox;
      await _hiveService.clear(box);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to clear tickets from local storage: ${e.toString()}',
        ),
      );
    }
  }
}
