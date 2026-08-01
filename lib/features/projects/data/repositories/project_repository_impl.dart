import 'package:flowtask/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:flowtask/features/projects/domain/entities/project_entity.dart';
import 'package:flowtask/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl(this._remoteDataSource);

  final ProjectRemoteDataSource _remoteDataSource;

  @override
  Future<List<ProjectEntity>> getProjects() {
    return _remoteDataSource.getProjects();
  }

  @override
  Future<ProjectEntity> createProject({
    required String name,
    required String description,
  }) {
    return _remoteDataSource.createProject(
      name: name,
      description: description,
    );
  }

  @override
  Future<ProjectEntity> updateProject({
    required String id,
    required String name,
    required String description,
  }) {
    return _remoteDataSource.updateProject(
      id: id,
      name: name,
      description: description,
    );
  }

  @override
  Future<void> deleteProject({required String id}) {
    return _remoteDataSource.deleteProject(id: id);
  }
}
