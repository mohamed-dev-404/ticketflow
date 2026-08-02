import 'package:flutter/foundation.dart';

@immutable
abstract class TicketState {}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketSuccess extends TicketState {}

class TicketFailure extends TicketState {
  final String errorMessage;

  TicketFailure(this.errorMessage);
}
