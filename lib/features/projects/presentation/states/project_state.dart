import 'package:flowtask/features/projects/domain/entities/project_entity.dart';

class ProjectState {
  const ProjectState({
    this.projects = const [],
    this.isLoading = false,
    this.error,
  });

  final List<ProjectEntity> projects;
  final bool isLoading;
  final String? error;

  ProjectState copyWith({
    List<ProjectEntity>? projects,
    bool? isLoading,
    String? error,
  }) {
    return ProjectState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
