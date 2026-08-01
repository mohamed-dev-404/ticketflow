import 'package:ticketflow/core/services/network/api_consumer.dart';
import 'package:ticketflow/core/services/network/dio_consumer.dart';
import 'package:ticketflow/core/services/cache/hive/hive_service.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source.dart';
import 'package:ticketflow/features/ticket_form/data/data_sources/ticket_form_local_data_source_impl.dart';
import 'package:ticketflow/features/ticket_form/data/repos/ticket_form_repo.dart';
import 'package:ticketflow/features/ticket_form/data/repos/ticket_form_repo_impl.dart';
import 'package:ticketflow/features/ticket_form/presentation/view_models/ticket_form_cubit/ticket_form_cubit.dart';
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

  //! Auth Feature

  //? Repo
  // getIt.registerLazySingleton<AuthRepo>(
  //   () => AuthRepoImpl(getIt<ApiConsumer>()),
  // );

  //? Cubits
  // getIt.registerFactory<LoginCubit>(
  //   () => LoginCubit(authRepo: getIt<AuthRepo>()),
  // );
  // getIt.registerFactory<RegisterCubit>(
  //   () => RegisterCubit(authRepo: getIt<AuthRepo>()),
  // );
  // getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt<AuthRepo>()));

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
}
