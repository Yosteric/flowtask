import 'package:flowtask/features/projects/domain/entities/project_entity.dart';
import 'package:flowtask/features/projects/domain/repositories/project_repository.dart';

class UpdateProjectUseCase {
  const UpdateProjectUseCase(this._repository);

  final ProjectRepository _repository;

  Future<ProjectEntity> call({
    required String id,
    required String name,
    required String description,
  }) {
    return _repository.updateProject(
      id: id,
      name: name,
      description: description,
    );
  }
}
