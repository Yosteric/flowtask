import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flowtask/features/dashboard/domain/entities/dashboard_statistics_entity.dart';
import 'package:flutter/material.dart';

class DashboardSummary extends StatelessWidget {
  const DashboardSummary({required this.statistics, super.key});

  const DashboardSummary.loading({super.key}) : statistics = null;

  const DashboardSummary.error({super.key}) : statistics = null;

  final DashboardStatisticsEntity? statistics;

  @override
  Widget build(BuildContext context) {
    if (statistics == null) {
      return _buildPlaceholder(context);
    }

    final items = [
      _SummaryItem(
        title: 'Projects',
        value: statistics!.totalProjects.toString(),
        icon: Icons.folder_outlined,
      ),
      _SummaryItem(
        title: 'Tasks',
        value: statistics!.totalTasks.toString(),
        icon: Icons.task_alt,
      ),
      _SummaryItem(
        title: 'Completed',
        value: statistics!.completedTasks.toString(),
        icon: Icons.check_circle_outline,
      ),
      _SummaryItem(
        title: 'Pending',
        value: statistics!.pendingTasks.toString(),
        icon: Icons.pending_actions,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.27,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return _SummaryCard(
          title: item.title,
          value: item.value,
          icon: item.icon,
        );
      },
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final items = [
      _SummaryItem(title: 'Projects', value: '—', icon: Icons.folder_outlined),
      _SummaryItem(title: 'Tasks', value: '—', icon: Icons.task_alt),
      _SummaryItem(
        title: 'Completed',
        value: '—',
        icon: Icons.check_circle_outline,
      ),
      _SummaryItem(title: 'Pending', value: '—', icon: Icons.pending_actions),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.27,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return _SummaryCard(
          title: item.title,
          value: item.value,
          icon: item.icon,
        );
      },
    );
  }
}

class _SummaryItem {
  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Text(title, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
