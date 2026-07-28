import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> splashRoutes = [
  GoRoute(
    path: AppRoutes.splash,
    name: 'splash',
    builder: (context, state) => const SplashScreen(),
  ),
];
