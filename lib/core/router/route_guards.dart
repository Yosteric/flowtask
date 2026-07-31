import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_controller_provider.dart';
import 'package:flowtask/features/authentication/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RouteGuards {
  static String? authentication(Ref ref, GoRouterState state) {
    final authState = ref.read(authControllerProvider);

    switch (authState.status) {
      case AuthStatus.initial:
      case AuthStatus.loading:
        return state.matchedLocation == AppRoutes.splash
            ? null
            : AppRoutes.splash;

      case AuthStatus.unauthenticated:
        return state.matchedLocation == AppRoutes.login
            ? null
            : AppRoutes.login;

      case AuthStatus.authenticated:
        return state.matchedLocation == AppRoutes.dashboard
            ? null
            : AppRoutes.dashboard;
      case AuthStatus.error:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
