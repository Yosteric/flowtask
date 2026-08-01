import 'package:flowtask/features/projects/data/models/project_model.dart';

abstract interface class ProjectRemoteDataSource {
  Future<List<ProjectModel>> getProjects();

  Future<ProjectModel> createProject({
    required String name,
    required String description,
  });

  Future<ProjectModel> updateProject({
    required String id,
    required String name,
    required String description,
  });

  Future<void> deleteProject({required String id});
}
