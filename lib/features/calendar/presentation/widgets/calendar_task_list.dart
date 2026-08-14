import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

class CalendarTaskList extends StatelessWidget {
  const CalendarTaskList({
    super.key,
    required this.tasks,
    required this.selectedDate,
  });

  final List<TaskEntity> tasks;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: Text('No tasks for this day.')),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tasks for ${_formatDate(selectedDate)}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...tasks.map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _CalendarTaskTile(task: task),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}

class _CalendarTaskTile extends StatelessWidget {
  const _CalendarTaskTile({required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        ),
        title: Text(
          task.title,
          style: task.isCompleted
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
        subtitle: task.description.isEmpty ? null : Text(task.description),
      ),
    );
  }
}
