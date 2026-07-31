import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/core/router/route_guards.dart';
import 'package:flowtask/core/router/router_refresh_listenable.dart';
import 'package:flowtask/features/authentication/routes/auth_routes.dart';
import 'package:flowtask/features/dashboard/routes/dashboard_routes.dart';
import 'package:flowtask/features/splash/routes/splash_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: ref.read(routerRefreshListenableProvider),
    redirect: (context, state) {
      return RouteGuards.authentication(ref, state);
    },
    routes: [...splashRoutes, ...authRoutes, ...dashboardRoutes],
  );
}
