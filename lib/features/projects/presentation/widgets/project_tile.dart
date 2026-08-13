import 'package:flowtask/features/projects/domain/entities/project_entity.dart';
import 'package:flowtask/features/projects/presentation/providers/project_progress_provider.dart';
import 'package:flowtask/features/projects/presentation/widgets/project_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProjectTile extends ConsumerWidget {
  const ProjectTile({
    super.key,
    required this.project,
    required this.onTap,
    required this.onDelete,
  });

  final ProjectEntity project;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(projectProgressProvider(project.id));

    return Card(
      child: ListTile(
        onTap: () => context.push('/tasks/${project.id}'),
        title: Text(project.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(project.description),
            const SizedBox(height: 8),
            progressAsync.when(
              loading: () => const LinearProgressIndicator(minHeight: 4),
              error: (_, _) => const SizedBox.shrink(),
              data: (progress) => ProjectProgressIndicator(progress: progress),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onTap();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Delete'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
