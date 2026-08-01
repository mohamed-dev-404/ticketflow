import 'package:flutter/foundation.dart';

@immutable
abstract class TicketFormState {}

class TicketFormInitial extends TicketFormState {}

class TicketFormLoading extends TicketFormState {}

class TicketFormSuccess extends TicketFormState {
  final String successMessage;

  TicketFormSuccess(this.successMessage);
}

class TicketFormFailure extends TicketFormState {
  final String errorMessage;

  TicketFormFailure(this.errorMessage);
}
