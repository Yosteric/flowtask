import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class GetAllTasksUseCase {
  GetAllTasksUseCase(this._repository);

  final TaskRepository _repository;

  Future<List<TaskEntity>> call() {
    return _repository.getAllTasks();
  }
}
