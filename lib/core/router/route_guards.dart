import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_controller_provider.dart';
import 'package:flowtask/features/authentication/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract final class RouteGuards {
  static String? authentication(Ref ref, GoRouterState state) {
    final authState = ref.read(authControllerProvider);

    final isLoggedIn = authState.status == AuthStatus.authenticated;

    final isLogin = state.matchedLocation == AppRoutes.login;

    final isSplash = state.matchedLocation == AppRoutes.splash;

    if (!isLoggedIn && !isLogin && !isSplash) {
      return AppRoutes.login;
    }

    if (isLoggedIn && (isLogin || isSplash)) {
      return AppRoutes.dashboard;
    }

    return null;
  }
}
