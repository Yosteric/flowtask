import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/presentation/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final List<TaskEntity> tasks;

  final void Function(TaskEntity task) onToggle;
  final void Function(TaskEntity task) onEdit;
  final void Function(TaskEntity task) onDelete;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks found.'));
    }

    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        final task = tasks[index];

        return TaskTile(
          task: task,
          onToggle: () => onToggle(task),
          onEdit: () => onEdit(task),
          onDelete: () => onDelete(task),
        );
      },
    );
  }
}
