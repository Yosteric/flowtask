import 'package:flowtask/features/projects/domain/entities/project_entity.dart';
import 'package:flowtask/features/projects/presentation/widgets/project_tile.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    super.key,
    required this.projects,
    required this.onProjectTap,
    required this.onDeleteProject,
  });

  final List<ProjectEntity> projects;
  final void Function(ProjectEntity project) onProjectTap;
  final void Function(ProjectEntity project) onDeleteProject;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: projects.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        return ProjectTile(
          project: projects[index],
          onTap: () => onProjectTap(projects[index]),
          onDelete: () => onDeleteProject(projects[index]),
        );
      },
    );
  }
}
