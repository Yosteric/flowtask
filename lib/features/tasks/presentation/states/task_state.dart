import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';

class TaskState {
  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<TaskEntity> tasks;
  final bool isLoading;
  final String? errorMessage;

  TaskState copyWith({
    List<TaskEntity>? tasks,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
