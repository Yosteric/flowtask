import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flowtask/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:flowtask/features/calendar/presentation/widgets/calendar_header.dart';
import 'package:flowtask/features/calendar/presentation/widgets/calendar_month_view.dart';
import 'package:flowtask/features/calendar/presentation/widgets/calendar_task_list.dart';
import 'package:flowtask/features/calendar/presentation/widgets/calendar_week_view.dart';
import 'package:flowtask/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _isMonthView = true;

  void _goToPreviousPeriod() {
    setState(() {
      _selectedDate = _isMonthView
          ? DateTime(_selectedDate.year, _selectedDate.month - 1, 1)
          : _selectedDate.subtract(const Duration(days: 7));
    });
  }

  void _goToNextPeriod() {
    setState(() {
      _selectedDate = _isMonthView
          ? DateTime(_selectedDate.year, _selectedDate.month + 1, 1)
          : _selectedDate.add(const Duration(days: 7));
    });
  }

  void _changeView(bool isMonthView) {
    setState(() {
      _isMonthView = isMonthView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(calendarTasksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: tasksAsync.when(
            loading: () => const Center(child: LoadingIndicator()),
            error: (_, _) => const EmptyState(
              title: 'Unable to load tasks',
              message: 'Something went wrong while loading your tasks.',
            ),
            data: (tasks) {
              final selectedDayTasks = tasks.where((task) {
                final dueDate = task.dueDate;

                return dueDate != null &&
                    dueDate.year == _selectedDate.year &&
                    dueDate.month == _selectedDate.month &&
                    dueDate.day == _selectedDate.day;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarHeader(
                    selectedDate: _selectedDate,
                    isMonthView: _isMonthView,
                    onPrevious: _goToPreviousPeriod,
                    onNext: _goToNextPeriod,
                    onViewChanged: _changeView,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  _isMonthView
                      ? CalendarMonthView(
                          selectedDate: _selectedDate,
                          tasks: tasks,
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                        )
                      : CalendarWeekView(
                          selectedDate: _selectedDate,
                          tasks: tasks,
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                        ),

                  const SizedBox(height: AppSpacing.lg),

                  CalendarTaskList(
                    selectedDate: _selectedDate,
                    tasks: selectedDayTasks,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
