import 'package:bloc/bloc.dart';
import 'package:ticketflow/features/dashboard/data/models/ticket_statistics_model.dart';
import 'package:ticketflow/features/dashboard/data/repos/dashboard_repo.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  TicketStatisticsModel statistics = TicketStatisticsModel.empty();

  DashboardCubit(this._repository) : super(DashboardInitial());

  Future<void> getDashboardStatistics() async {
    emit(DashboardLoading());

    final result = await _repository.getAllStatusCounts();

    result.fold(
      (error) => emit(DashboardFailure(error)),
      (fetchedStatistics) {
        statistics = fetchedStatistics;
        emit(DashboardSuccess());
      },
    );
  }
}
