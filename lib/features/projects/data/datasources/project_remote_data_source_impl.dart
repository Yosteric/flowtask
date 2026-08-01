import 'package:flowtask/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:flowtask/features/projects/data/models/project_model.dart';

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final List<ProjectModel> _projects = [];

  @override
  Future<List<ProjectModel>> getProjects() async {
    return List.unmodifiable(_projects);
  }

  @override
  Future<ProjectModel> createProject({
    required String name,
    required String description,
  }) async {
    final project = ProjectModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _projects.add(project);

    return project;
  }

  @override
  Future<ProjectModel> updateProject({
    required String id,
    required String name,
    required String description,
  }) async {
    final index = _projects.indexWhere((project) => project.id == id);

    if (index == -1) {
      throw Exception('Project not found');
    }

    final updated = ProjectModel(
      id: id,
      name: name,
      description: description,
      createdAt: _projects[index].createdAt,
      updatedAt: DateTime.now(),
    );

    _projects[index] = updated;

    return updated;
  }

  @override
  Future<void> deleteProject({required String id}) async {
    _projects.removeWhere((project) => project.id == id);
  }
}
