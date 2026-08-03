import 'package:ticketflow/core/services/network/api_consumer.dart';
import 'package:ticketflow/core/services/network/dio_consumer.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source_impl.dart';
import 'package:ticketflow/features/ticket_form/data/repos/ticket_form_repo.dart';
import 'package:ticketflow/features/ticket_form/data/repos/ticket_form_repo_impl.dart';
import 'package:ticketflow/features/ticket_form/presentation/view_models/ticket_form_cubit/ticket_form_cubit.dart';
import 'package:ticketflow/features/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:ticketflow/features/dashboard/data/data_sources/dashboard_local_data_source_impl.dart';
import 'package:ticketflow/features/dashboard/data/repos/dashboard_repo.dart';
import 'package:ticketflow/features/dashboard/data/repos/dashboard_repo_impl.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_cubit.dart';
import 'package:ticketflow/features/search/data/data_sources/search_local_data_source.dart';
import 'package:ticketflow/features/search/data/data_sources/search_local_data_source_impl.dart';
import 'package:ticketflow/features/search/data/repos/search_repo.dart';
import 'package:ticketflow/features/search/data/repos/search_repo_impl.dart';
import 'package:ticketflow/features/search/presentation/view_models/search_cubit/search_cubit.dart';
import 'package:ticketflow/features/tickets/data/data_sources/ticket_local_data_source.dart';
import 'package:ticketflow/features/tickets/data/data_sources/ticket_local_data_source_impl.dart';
import 'package:ticketflow/features/tickets/data/repos/tickets_repo.dart';
import 'package:ticketflow/features/tickets/data/repos/tickets_repo_impl.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// This file is responsible for registering all the services
/// that will be used in the app using GetIt package for [dependency_injection].
final GetIt getIt = GetIt.instance;

//* This function will be called in the main function before running the app
void setupServiceLocator() {
  //! shared network services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(getIt<Dio>()));

  //! Ticket Form Feature

  //? Data Source
  getIt.registerLazySingleton<TicketFormLocalDataSource>(
    () => TicketFormLocalDataSourceImpl(HiveService.instance),
  );

  //? Repo
  getIt.registerLazySingleton<TicketFormRepository>(
    () => TicketFormRepositoryImpl(getIt<TicketFormLocalDataSource>()),
  );

  //? Cubit
  getIt.registerFactory<TicketFormCubit>(
    () => TicketFormCubit(getIt<TicketFormRepository>()),
  );

  //! Tickets Feature

  //? Data Source
  getIt.registerLazySingleton<TicketLocalDataSource>(
    () => TicketLocalDataSourceImpl(HiveService.instance),
  );

  //? Repo
  getIt.registerLazySingleton<TicketsRepository>(
    () => TicketsRepositoryImpl(getIt<TicketLocalDataSource>()),
  );

  //? Cubit
  getIt.registerFactory<TicketCubit>(
    () => TicketCubit(getIt<TicketsRepository>()),
  );

  //! Search Feature

  //? Data Source
  getIt.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(HiveService.instance),
  );

  //? Repo
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt<SearchLocalDataSource>()),
  );

  //? Cubit
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<SearchRepository>()),
  );

  //! Dashboard Feature

  //? Data Source
  getIt.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(HiveService.instance),
  );

  //? Repo
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt<DashboardLocalDataSource>()),
  );

  //? Cubit
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(getIt<DashboardRepository>()),
  );
}
