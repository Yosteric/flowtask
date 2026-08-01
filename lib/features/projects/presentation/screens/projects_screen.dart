import 'package:flowtask/features/projects/presentation/providers/project_providers.dart';
import 'package:flowtask/features/projects/presentation/widgets/project_dialog.dart';
import 'package:flowtask/features/projects/presentation/widgets/project_list.dart';
import 'package:flowtask/shared/widgets/indicators/loading_indicator.dart';
import 'package:flowtask/shared/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Builder(
        builder: (_) {
          if (state.isLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state.projects.isEmpty) {
            return const EmptyState(
              title: 'No projects yet',
              message: 'Create your first project.',
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ProjectList(
              projects: state.projects,
              onProjectTap: (project) {
                showDialog<void>(
                  context: context,
                  builder: (_) {
                    return ProjectDialog(
                      project: project,
                      onSave: (name, description) async {
                        await ref
                            .read(projectControllerProvider.notifier)
                            .updateProject(
                              id: project.id,
                              name: name,
                              description: description,
                            );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Project updated successfully'),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              onDeleteProject: (project) async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Delete Project'),
                      content: Text(
                        'Are you sure you want to delete "${project.name}"?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );

                if (confirmed != true || !context.mounted) return;

                await ref
                    .read(projectControllerProvider.notifier)
                    .deleteProject(id: project.id);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${project.name}" deleted successfully'),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) {
              return ProjectDialog(
                onSave: (name, description) async {
                  await ref
                      .read(projectControllerProvider.notifier)
                      .createProject(name: name, description: description);

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Project created successfully'),
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
