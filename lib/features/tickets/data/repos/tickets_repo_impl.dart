import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/errors/exceptions/app_exception.dart';
import 'package:ticketflow/features/tickets/data/data_sources/ticket_local_data_source.dart';
import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/features/tickets/data/repos/tickets_repo.dart';

class TicketsRepositoryImpl implements TicketsRepository {
  final TicketLocalDataSource _localDataSource;

  TicketsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<String, List<TicketModel>>> getAllTickets() async {
    try {
      final result = await _localDataSource.getAllTickets();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteTicket(String id) async {
    try {
      await _localDataSource.deleteTicket(id);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteAllTickets() async {
    try {
      await _localDataSource.deleteAllTickets();
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
