import 'package:flowtask/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._remoteDataSource);

  final TaskRemoteDataSource _remoteDataSource;

  @override
  Future<List<TaskEntity>> getTasks({required String projectId}) async {
    final tasks = await _remoteDataSource.getTasks(projectId: projectId);

    return tasks.map((task) => task.toEntity()).toList();
  }

  @override
  Future<TaskEntity> createTask({
    required String projectId,
    required String title,
    required String description,
  }) async {
    final task = await _remoteDataSource.createTask(
      projectId: projectId,
      title: title,
      description: description,
    );

    return task.toEntity();
  }

  @override
  Future<TaskEntity> updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    final task = await _remoteDataSource.updateTask(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );

    return task.toEntity();
  }

  @override
  Future<void> deleteTask({required String id}) {
    return _remoteDataSource.deleteTask(id: id);
  }
}
