import 'package:flowtask/features/projects/domain/usecases/create_project_use_case.dart';
import 'package:flowtask/features/projects/domain/usecases/delete_project_use_case.dart';
import 'package:flowtask/features/projects/domain/usecases/get_projects_use_case.dart';
import 'package:flowtask/features/projects/domain/usecases/update_project_use_case.dart';
import 'package:flowtask/features/projects/presentation/providers/project_providers.dart';
import 'package:flowtask/features/projects/presentation/states/project_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectController extends Notifier<ProjectState> {
  late final GetProjectsUseCase _getProjects;
  late final CreateProjectUseCase _createProject;
  late final UpdateProjectUseCase _updateProject;
  late final DeleteProjectUseCase _deleteProject;

  @override
  ProjectState build() {
    _getProjects = ref.read(getProjectsUseCaseProvider);
    _createProject = ref.read(createProjectUseCaseProvider);
    _updateProject = ref.read(updateProjectUseCaseProvider);
    _deleteProject = ref.read(deleteProjectUseCaseProvider);

    _loadProjects();

    return const ProjectState();
  }

  Future<void> _loadProjects() async {
    state = state.copyWith(isLoading: true);

    try {
      final projects = await _getProjects();

      state = state.copyWith(projects: projects, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createProject({
    required String name,
    required String description,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final project = await _createProject(
        name: name,
        description: description,
      );

      state = state.copyWith(
        isLoading: false,
        projects: [...state.projects, project],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateProject({
    required String id,
    required String name,
    required String description,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updated = await _updateProject(
        id: id,
        name: name,
        description: description,
      );

      final projects = state.projects
          .map((project) => project.id == updated.id ? updated : project)
          .toList();

      state = state.copyWith(isLoading: false, projects: projects);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteProject({required String id}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _deleteProject(id: id);

      state = state.copyWith(
        isLoading: false,
        projects: state.projects.where((project) => project.id != id).toList(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
