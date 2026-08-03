import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/core/errors/exceptions/app_exception.dart';
import 'package:ticketflow/features/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:ticketflow/features/dashboard/data/models/ticket_statistics_model.dart';
import 'package:ticketflow/features/dashboard/data/repos/dashboard_repo.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource _localDataSource;

  DashboardRepositoryImpl(this._localDataSource);

  @override
  Future<Either<String, int>> getTotalCount() async {
    try {
      final result = await _localDataSource.getTotalCount();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, int>> getCountByStatus(TicketStatus status) async {
    try {
      final result = await _localDataSource.getCountByStatus(status);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TicketStatisticsModel>> getAllStatusCounts() async {
    try {
      final result = await _localDataSource.getAllStatusCounts();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
