import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/errors/exceptions/app_exception.dart';
import 'package:ticketflow/features/search/data/data_sources/search_local_data_source.dart';
import 'package:ticketflow/features/search/data/repos/search_repo.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource _localDataSource;

  SearchRepositoryImpl(this._localDataSource);

  @override
  Future<Either<String, List<TicketModel>>> searchBySubject(String query) async {
    try {
      final result = await _localDataSource.searchBySubject(query);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TicketModel>>> getTicketsByStatus(
    TicketStatus status,
  ) async {
    try {
      final result = await _localDataSource.getTicketsByStatus(status);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TicketModel>>> searchTickets({
    String? subject,
    TicketStatus? status,
  }) async {
    try {
      final result = await _localDataSource.searchTickets(
        subject: subject,
        status: status,
      );
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
