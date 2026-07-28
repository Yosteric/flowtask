import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> dashboardRoutes = [
  GoRoute(
    path: AppRoutes.dashboard,
    name: 'dashboard',
    builder: (context, state) => const DashboardScreen(),
  ),
];
