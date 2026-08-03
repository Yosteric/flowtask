import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  const CreateTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<TaskEntity> call({
    required String projectId,
    required String title,
    required String description,
  }) {
    return _repository.createTask(
      projectId: projectId,
      title: title,
      description: description,
    );
  }
}
