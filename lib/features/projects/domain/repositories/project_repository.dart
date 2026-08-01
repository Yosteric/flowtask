import 'package:flowtask/features/projects/domain/entities/project_entity.dart';

abstract interface class ProjectRepository {
  Future<List<ProjectEntity>> getProjects();

  Future<ProjectEntity> createProject({
    required String name,
    required String description,
  });

  Future<ProjectEntity> updateProject({
    required String id,
    required String name,
    required String description,
  });

  Future<void> deleteProject({required String id});
}
