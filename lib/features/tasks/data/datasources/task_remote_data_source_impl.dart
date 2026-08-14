import 'package:flowtask/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flowtask/features/tasks/data/models/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final List<TaskModel> _tasks = [];

  @override
  Future<List<TaskModel>> getTasks({required String projectId}) async {
    return _tasks.where((task) => task.projectId == projectId).toList();
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return List<TaskModel>.from(_tasks);
  }

  @override
  Future<TaskModel> createTask({
    required String projectId,
    required String title,
    required String description,
    DateTime? dueDate,
  }) async {
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      projectId: projectId,
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );

    _tasks.add(task);

    return task;
  }

  @override
  Future<TaskModel> updateTask({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    DateTime? dueDate,
  }) async {
    final index = _tasks.indexWhere((task) => task.id == id);

    final updated = TaskModel(
      id: _tasks[index].id,
      projectId: _tasks[index].projectId,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: _tasks[index].createdAt,
      dueDate: dueDate,
    );

    _tasks[index] = updated;

    return updated;
  }

  @override
  Future<void> deleteTask({required String id}) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
