import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketflow/core/routes/routes.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
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
    ],
  );
}
