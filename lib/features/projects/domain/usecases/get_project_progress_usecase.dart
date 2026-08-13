import 'package:flowtask/features/projects/domain/entities/project_progress_entity.dart';
import 'package:flowtask/features/projects/domain/repositories/project_progress_repository.dart';

class GetProjectProgressUseCase {
  const GetProjectProgressUseCase(this._repository);

  final ProjectProgressRepository _repository;

  Future<ProjectProgressEntity> call({required String projectId}) {
    return _repository.getProjectProgress(projectId: projectId);
  }
}
