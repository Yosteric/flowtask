import 'package:flowtask/features/projects/domain/repositories/project_repository.dart';

class DeleteProjectUseCase {
  const DeleteProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<void> call({required String id}) {
    return _repository.deleteProject(id: id);
  }
}
