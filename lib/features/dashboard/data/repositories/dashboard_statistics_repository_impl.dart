import 'package:flowtask/features/dashboard/domain/entities/dashboard_statistics_entity.dart';
import 'package:flowtask/features/dashboard/domain/repositories/dashboard_statistics_repository.dart';
import 'package:flowtask/features/projects/domain/repositories/project_repository.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class DashboardStatisticsRepositoryImpl
    implements DashboardStatisticsRepository {
  const DashboardStatisticsRepositoryImpl({
    required this._projectRepository,
    required this._taskRepository,
  });

  final ProjectRepository _projectRepository;
  final TaskRepository _taskRepository;

  @override
  Future<DashboardStatisticsEntity> getStatistics() async {
    final projects = await _projectRepository.getProjects();

    final taskLists = await Future.wait(
      projects.map(
        (project) => _taskRepository.getTasks(projectId: project.id),
      ),
    );

    final tasks = taskLists.expand((taskList) => taskList);

    var completedTasks = 0;
    var pendingTasks = 0;

    for (final task in tasks) {
      if (task.isCompleted) {
        completedTasks++;
      } else {
        pendingTasks++;
      }
    }

    return DashboardStatisticsEntity(
      totalProjects: projects.length,
      totalTasks: completedTasks + pendingTasks,
      completedTasks: completedTasks,
      pendingTasks: pendingTasks,
    );
  }
}
