import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/errors/exceptions/cache_exception.dart';
import 'package:ticketflow/core/errors/models/error_model.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/search/data/data_sources/search_local_data_source.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

///! ===================================================
///! SearchLocalDataSourceImpl
///! ===================================================
///* Implementation of [SearchLocalDataSource].
///* Delegates all persistence operations to [HiveService] generic helpers.
class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final HiveService _hiveService;

  SearchLocalDataSourceImpl(this._hiveService);

  @override
  Future<List<TicketModel>> searchBySubject(String query) async {
    try {
      final box = _hiveService.ticketsBox;
      final allTickets = _hiveService.getAll(box);
      final lowerQuery = query.toLowerCase();

      return allTickets
          .where((ticket) => ticket.subject.toLowerCase().contains(lowerQuery))
          .toList();
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage:
              'Failed to search tickets by subject from local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<List<TicketModel>> getTicketsByStatus(TicketStatus status) async {
    try {
      final box = _hiveService.ticketsBox;
      final allTickets = _hiveService.getAll(box);

      return allTickets
          .where((ticket) => ticket.status == status)
          .toList();
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage:
              'Failed to filter tickets by status from local storage: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<List<TicketModel>> searchTickets({
    String? subject,
    TicketStatus? status,
  }) async {
    try {
      final box = _hiveService.ticketsBox;
      List<TicketModel> results = _hiveService.getAll(box);

      if (subject != null && subject.isNotEmpty) {
        final lowerQuery = subject.toLowerCase();
        results = results
            .where(
                (ticket) => ticket.subject.toLowerCase().contains(lowerQuery))
            .toList();
      }

      if (status != null) {
        results =
            results.where((ticket) => ticket.status == status).toList();
      }

      return results;
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage:
              'Failed to search tickets from local storage: ${e.toString()}',
        ),
      );
    }
  }
}
