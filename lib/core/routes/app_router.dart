import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketflow/core/di/service_locator.dart';
import 'package:ticketflow/core/routes/routes.dart';
import 'package:ticketflow/features/home/presentation/views/home_view.dart';
import 'package:ticketflow/features/ticket_form/presentation/view_models/ticket_form_cubit/ticket_form_cubit.dart';
import 'package:ticketflow/features/ticket_form/presentation/views/ticket_form_view.dart';
import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.home,
    routes: [
      //* Home view (Test)
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeView(),
      ),

      //* Splash view
      // GoRoute(
      //   path: Routes.splash,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<SplashCubit>()..getInitData(),
      //     child: const SplashView(),
      //   ),
      // ),

      //* Login view
      // GoRoute(
      //   path: Routes.login,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<LoginCubit>(),
      //     child: const LoginView(),
      //   ),
      // ),

      // * Public profile view
      // GoRoute(
      //   path: Routes.publicProfilePath,
      //   builder: (context, state) {
      //     final userId =
      //         int.tryParse(state.pathParameters['userId'] ?? '') ?? 0;

      //     return BlocProvider(
      //       create: (context) =>
      //           getIt<PublicProfileCubit>()..getPublicProfile(userId),
      //       child: const PublicProfileView(),
      //     );
      //   },
      // ),

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
    ],
  );
}
