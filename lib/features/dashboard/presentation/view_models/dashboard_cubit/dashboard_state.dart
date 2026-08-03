import 'package:flutter/foundation.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {}

class DashboardFailure extends DashboardState {
  final String errorMessage;

  DashboardFailure(this.errorMessage);
}
