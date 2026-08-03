import 'package:bloc/bloc.dart';
import 'package:ticketflow/core/enums/ticket_category.dart';
import 'package:ticketflow/core/enums/ticket_priority.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/features/ticket_form/data/repos/ticket_form_repo.dart';
import 'package:ticketflow/core/models/ticket_model.dart';
import 'package:uuid/uuid.dart';

import 'ticket_form_state.dart';

class TicketFormCubit extends Cubit<TicketFormState> {
  final TicketFormRepository _repository;
  final Uuid _uuid;

  TicketFormCubit(this._repository)
    : _uuid = const Uuid(),
      super(TicketFormInitial());

  String _generateTicketNumber(TicketCategory category, String uuid) {
    final uniqueSuffix = uuid.split('-').first.toUpperCase();
    return '${category.prefix}-$uniqueSuffix';
  }

  Future<void> addTicket({
    required String subject,
    required String description,
    required TicketPriority priority,
    required TicketCategory category,
  }) async {
    emit(TicketFormLoading());

    final id = _uuid.v4();
    final ticketNumber = _generateTicketNumber(category, id);
    final createdAt = DateTime.now();

    final ticket = TicketModel(
      id: id,
      ticketNumber: ticketNumber,
      subject: subject,
      description: description,
      priority: priority,
      category: category,
      status: TicketStatus.open,
      createdAt: createdAt,
    );

    final result = await _repository.addTicket(ticket);

    result.fold(
      (error) => emit(TicketFormFailure(error)),
      (_) =>
          emit(TicketFormSuccess('Ticket $ticketNumber created successfully')),
    );
  }

  Future<void> updateTicket(TicketModel ticket) async {
    emit(TicketFormLoading());

    final result = await _repository.updateTicket(ticket);

    result.fold(
      (error) => emit(TicketFormFailure(error)),
      (_) => emit(
        TicketFormSuccess('Ticket ${ticket.ticketNumber} edited successfully'),
      ),
    );
  }
}
