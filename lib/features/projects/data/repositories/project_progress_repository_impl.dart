import 'package:flowtask/features/projects/domain/entities/project_progress_entity.dart';
import 'package:flowtask/features/projects/domain/repositories/project_progress_repository.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class ProjectProgressRepositoryImpl implements ProjectProgressRepository {
  const ProjectProgressRepositoryImpl(this._taskRepository);

  final TaskRepository _taskRepository;

  @override
  Future<ProjectProgressEntity> getProjectProgress({
    required String projectId,
  }) async {
    final tasks = await _taskRepository.getTasks(projectId: projectId);

    final completedTasks = tasks.where((task) => task.isCompleted).length;

    return ProjectProgressEntity(
      totalTasks: tasks.length,
      completedTasks: completedTasks,
    );
  }
}
