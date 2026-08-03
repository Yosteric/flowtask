import 'package:flowtask/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:flowtask/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:flowtask/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:flowtask/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:flowtask/features/tasks/presentation/providers/task_providers.dart';
import 'package:flowtask/features/tasks/presentation/states/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskController extends Notifier<TaskState> {
  late final GetTasksUseCase _getTasks;
  late final CreateTaskUseCase _createTask;
  late final UpdateTaskUseCase _updateTask;
  late final DeleteTaskUseCase _deleteTask;

  @override
  TaskState build() {
    _getTasks = ref.read(getTasksUseCaseProvider);
    _createTask = ref.read(createTaskUseCaseProvider);
    _updateTask = ref.read(updateTaskUseCaseProvider);
    _deleteTask = ref.read(deleteTaskUseCaseProvider);

    return const TaskState();
  }

  Future<void> loadTasks({required String projectId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final tasks = await _getTasks(projectId: projectId);

      state = state.copyWith(tasks: tasks, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createTask({
    required String projectId,
    required String title,
    required String description,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _createTask(
        projectId: projectId,
        title: title,
        description: description,
      );

      await loadTasks(projectId: projectId);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateTask({
    required String projectId,
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _updateTask(
        id: id,
        title: title,
        description: description,
        isCompleted: isCompleted,
      );

      await loadTasks(projectId: projectId);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteTask({
    required String projectId,
    required String id,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _deleteTask(id: id);

      await loadTasks(projectId: projectId);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
