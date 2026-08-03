import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  const UpdateTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<TaskEntity> call({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) {
    return _repository.updateTask(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }
}
