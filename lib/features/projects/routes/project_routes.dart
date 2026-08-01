import 'package:flowtask/features/projects/presentation/screens/projects_screen.dart';
import 'package:go_router/go_router.dart';

final projectRoutes = <RouteBase>[
  GoRoute(
    path: '/projects',
    builder: (context, state) => const ProjectsScreen(),
  ),
];
