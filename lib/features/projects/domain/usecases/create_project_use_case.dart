import 'package:flowtask/features/projects/domain/entities/project_entity.dart';
import 'package:flowtask/features/projects/domain/repositories/project_repository.dart';

class CreateProjectUseCase {
  const CreateProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<ProjectEntity> call({
    required String name,
    required String description,
  }) {
    return _repository.createProject(name: name, description: description);
  }
}
