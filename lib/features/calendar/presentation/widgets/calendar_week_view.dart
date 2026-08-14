import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

class CalendarWeekView extends StatelessWidget {
  const CalendarWeekView({
    required this.selectedDate,
    required this.tasks,
    required this.onDateSelected,
    super.key,
  });

  final DateTime selectedDate;
  final List<TaskEntity> tasks;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final weekDays = _getWeekDays(selectedDate);

    return Row(
      children: weekDays.map((date) {
        return Expanded(
          child: _WeekDayHeader(
            date: date,
            isSelected: _isSameDay(date, selectedDate),
            isToday: _isSameDay(date, DateTime.now()),
            taskCount: _taskCountForDate(date),
            onTap: () => onDateSelected(date),
          ),
        );
      }).toList(),
    );
  }

  List<DateTime> _getWeekDays(DateTime date) {
    final monday = date.subtract(
      Duration(days: date.weekday - DateTime.monday),
    );

    return List.generate(
      7,
      (index) => DateTime(monday.year, monday.month, monday.day + index),
    );
  }

  int _taskCountForDate(DateTime date) {
    return tasks.where((task) {
      final dueDate = task.dueDate;

      return dueDate != null && _isSameDay(dueDate, date);
    }).length;
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}

class _WeekDayHeader extends StatelessWidget {
  const _WeekDayHeader({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.taskCount,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final int taskCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            children: [
              Text(
                _weekdayName(date.weekday),
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(height: 4),
              Text(
                '${date.day}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: isToday || isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (taskCount > 0) ...[
                const SizedBox(height: 2),
                Text(
                  '$taskCount',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _weekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return weekdays[weekday - 1];
  }
}
