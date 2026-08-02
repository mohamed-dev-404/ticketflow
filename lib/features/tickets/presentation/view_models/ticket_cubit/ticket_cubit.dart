import 'package:bloc/bloc.dart';
import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/features/tickets/data/repos/tickets_repo.dart';

import 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final TicketsRepository _repository;

  List<TicketModel> tickets = [];

  TicketCubit(this._repository) : super(TicketInitial());

  Future<void> getAllTickets() async {
    emit(TicketLoading());

    final result = await _repository.getAllTickets();

    result.fold(
      (error) => emit(TicketFailure(error)),
      (fetchedTickets) {
        final sortedTickets = List<TicketModel>.from(fetchedTickets)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        tickets = sortedTickets;
        emit(TicketSuccess());
      },
    );
  }

  Future<void> deleteTicketById(String id) async {
    emit(TicketLoading());

    final result = await _repository.deleteTicket(id);

    result.fold(
      (error) => emit(TicketFailure(error)),
      (_) {
        getAllTickets();
      },
    );
  }
}
