import 'package:flowtask/features/tasks/presentation/providers/task_providers.dart';
import 'package:flowtask/features/tasks/presentation/widgets/task_dialog.dart';
import 'package:flowtask/features/tasks/presentation/widgets/task_list.dart';
import 'package:flowtask/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key, required this.projectId});

  final String projectId;

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(taskControllerProvider.notifier)
          .loadTasks(projectId: widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SectionTitle(
              title: 'Tasks',
              subtitle: 'Manage your project tasks',
            ),

            const SizedBox(height: 16),

            AppSearchField(
              controller: TextEditingController(),
              onChanged: (value) {
                // TODO(search)
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Builder(
                builder: (_) {
                  if (state.isLoading) {
                    return const LoadingIndicator();
                  }

                  if (state.tasks.isEmpty) {
                    return const EmptyState(
                      title: 'No tasks found',
                      message: 'Create your first task to get started.',
                    );
                  }

                  return TaskList(
                    tasks: state.tasks,
                    onToggle: (task) {
                      ref
                          .read(taskControllerProvider.notifier)
                          .updateTask(
                            id: task.id,
                            projectId: widget.projectId,
                            title: task.title,
                            description: task.description,
                            isCompleted: !task.isCompleted,
                          );
                    },
                    onEdit: (task) {
                      _showEditDialog(context, task);
                    },
                    onDelete: (task) {
                      ref
                          .read(taskControllerProvider.notifier)
                          .deleteTask(id: task.id, projectId: widget.projectId);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => TaskDialog(
        onSave: (title, description) {
          return ref
              .read(taskControllerProvider.notifier)
              .createTask(
                projectId: widget.projectId,
                title: title,
                description: description,
              );
        },
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, task) async {
    await showDialog(
      context: context,
      builder: (_) => TaskDialog(
        task: task,
        onSave: (title, description) {
          return ref
              .read(taskControllerProvider.notifier)
              .updateTask(
                id: task.id,
                projectId: widget.projectId,
                title: title,
                description: description,
                isCompleted: task.isCompleted,
              );
        },
      ),
    );
  }
}
