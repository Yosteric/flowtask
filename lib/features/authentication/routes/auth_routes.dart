import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/features/authentication/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> authRoutes = [
  GoRoute(
    path: AppRoutes.login,
    name: 'login',
    builder: (context, state) => const LoginScreen(),
  ),
];
