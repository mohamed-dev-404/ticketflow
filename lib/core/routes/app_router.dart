import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketflow/core/di/service_locator.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/features/home/presentation/views/home_view.dart';
import 'package:ticketflow/features/ticket_form/presentation/view_models/ticket_form_cubit/ticket_form_cubit.dart';
import 'package:ticketflow/features/ticket_form/presentation/views/ticket_form_view.dart';
import 'package:ticketflow/features/dashboard/presentation/view_models/dashboard_cubit/dashboard_cubit.dart';
import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/features/tickets/presentation/view_models/ticket_cubit/ticket_cubit.dart';

import 'package:ticketflow/features/tickets/presentation/views/ticket_details.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      //* Splash view
      // GoRoute(
      //   path: Routes.splash,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<SplashCubit>()..getInitData(),
      //     child: const SplashView(),
      //   ),
      // ),

      //* Home view
      GoRoute(
        path: Routes.home,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  getIt<DashboardCubit>()..getDashboardStatistics(),
            ),
            BlocProvider(
              create: (context) => getIt<TicketCubit>()..getAllTickets(),
            ),
          ],
          child: const HomeView(),
        ),
      ),

      //* Ticket Form view (Add / Edit)
      GoRoute(
        path: Routes.ticketForm,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final isEdit = extra['isEdit'] as bool;
          final ticket = extra['ticket'] as TicketModel?;

          return BlocProvider(
            create: (context) => getIt<TicketFormCubit>(),
            child: TicketFormView(isEdit: isEdit, ticket: ticket),
          );
        },
      ),

      //* Ticket Details view
      GoRoute(
        path: Routes.ticketDetails,
        builder: (context, state) {
          final ticket = state.extra as TicketModel;
          return BlocProvider(
            create: (context) => getIt<TicketCubit>(),
            child: TicketDetails(ticket: ticket),
          );
        },
      ),
    ],
  );
}
