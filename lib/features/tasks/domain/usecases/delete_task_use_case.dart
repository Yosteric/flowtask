import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  const DeleteTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<void> call({required String id}) {
    return _repository.deleteTask(id: id);
  }
}
