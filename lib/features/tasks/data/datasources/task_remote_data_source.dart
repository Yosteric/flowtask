import 'package:flowtask/features/tasks/data/models/task_model.dart';

abstract interface class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks({required String projectId});

  Future<List<TaskModel>> getAllTasks();

  Future<TaskModel> createTask({
    required String projectId,
    required String title,
    required String description,
    DateTime? dueDate,
  });

  Future<TaskModel> updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    DateTime? dueDate,
  });

  Future<void> deleteTask({required String id});
}
