import 'package:flowtask/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> splashRoutes = [
  GoRoute(
    path: '/',
    name: 'splash',
    builder: (context, state) => const SplashScreen(),
  ),
];
