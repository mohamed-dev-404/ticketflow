import 'package:dartz/dartz.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/features/dashboard/data/models/ticket_statistics_model.dart';

abstract class DashboardRepository {
  Future<Either<String, int>> getTotalCount();
  Future<Either<String, int>> getCountByStatus(TicketStatus status);
  Future<Either<String, TicketStatisticsModel>> getAllStatusCounts();
}
