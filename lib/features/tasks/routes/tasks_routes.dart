import 'package:flowtask/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:go_router/go_router.dart';

class TasksRoutes {
  static GoRoute route() {
    return GoRoute(
      path: '/tasks/:projectId',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;

        return TasksScreen(projectId: projectId);
      },
    );
  }
}
