import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

class CalendarMonthView extends StatelessWidget {
  const CalendarMonthView({
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
    final days = _buildCalendarDays(selectedDate);

    return Column(
      children: [
        _buildWeekdayHeader(context),
        const SizedBox(height: AppSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: AppSpacing.xs,
            mainAxisSpacing: AppSpacing.xs,
          ),
          itemBuilder: (context, index) {
            final date = days[index];

            if (date == null) {
              return const SizedBox.shrink();
            }

            return _CalendarDay(
              date: date,
              isSelected: _isSameDay(date, selectedDate),
              isToday: _isSameDay(date, DateTime.now()),
              taskCount: _taskCountForDate(date),
              onTap: () => onDateSelected(date),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader(BuildContext context) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Row(
      children: weekdays
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  List<DateTime?> _buildCalendarDays(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;

    // DateTime.monday = 1, Sunday = 7.
    final leadingEmptyDays = firstDay.weekday - 1;

    return [
      ...List<DateTime?>.filled(leadingEmptyDays, null),
      for (var day = 1; day <= daysInMonth; day++)
        DateTime(date.year, date.month, day),
    ];
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

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
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
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${date.day}',
                style: theme.textTheme.bodyMedium?.copyWith(
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
}
