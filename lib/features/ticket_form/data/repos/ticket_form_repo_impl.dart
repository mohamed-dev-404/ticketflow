import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/errors/exceptions/app_exception.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source.dart';
import 'package:ticketflow/features/ticket_form/data/repos/ticket_form_repo.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

class TicketFormRepositoryImpl implements TicketFormRepository {
  final TicketFormLocalDataSource _localDataSource;

  TicketFormRepositoryImpl(this._localDataSource);

  @override
  Future<Either<String, Unit>> addTicket(TicketModel ticket) async {
    try {
      await _localDataSource.addTicket(ticket);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateTicket(TicketModel ticket) async {
    try {
      await _localDataSource.updateTicket(ticket);
      return const Right(unit);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> exists(String id) async {
    try {
      final result = await _localDataSource.exists(id);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
