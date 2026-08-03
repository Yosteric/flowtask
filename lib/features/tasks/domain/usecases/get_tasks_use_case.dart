import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  const GetTasksUseCase(this._repository);

  final TaskRepository _repository;

  Future<List<TaskEntity>> call({required String projectId}) {
    return _repository.getTasks(projectId: projectId);
  }
}
