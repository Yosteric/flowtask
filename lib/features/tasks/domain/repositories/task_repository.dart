import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';

abstract interface class TaskRepository {
  Future<List<TaskEntity>> getTasks({required String projectId});

  Future<List<TaskEntity>> getAllTasks();

  Future<TaskEntity> createTask({
    required String projectId,
    required String title,
    required String description,
    DateTime? dueDate,
  });

  Future<TaskEntity> updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    DateTime? dueDate,
  });

  Future<void> deleteTask({required String id});
}
