import 'package:flowtask/features/tasks/data/models/task_model.dart';

abstract interface class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks({required String projectId});

  Future<TaskModel> createTask({
    required String projectId,
    required String title,
    required String description,
  });

  Future<TaskModel> updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  });

  Future<void> deleteTask({required String id});
}
