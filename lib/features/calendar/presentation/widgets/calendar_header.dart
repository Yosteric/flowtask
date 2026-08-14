import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    required this.selectedDate,
    required this.isMonthView,
    required this.onPrevious,
    required this.onNext,
    required this.onViewChanged,
    super.key,
  });

  final DateTime selectedDate;
  final bool isMonthView;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final ValueChanged<bool> onViewChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _formatDate(selectedDate),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              onPressed: onPrevious,
              icon: const Icon(Icons.chevron_left),
            ),
            IconButton(
              onPressed: onNext,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment<bool>(
              value: true,
              label: Text('Month'),
              icon: Icon(Icons.calendar_month),
            ),
            ButtonSegment<bool>(
              value: false,
              label: Text('Week'),
              icon: Icon(Icons.view_week),
            ),
          ],
          selected: {isMonthView},
          onSelectionChanged: (selection) {
            onViewChanged(selection.first);
          },
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}
