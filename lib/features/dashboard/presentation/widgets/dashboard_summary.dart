import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flowtask/shared/widgets/cards/app_card.dart';
import 'package:flutter/material.dart';

class DashboardSummary extends StatelessWidget {
  const DashboardSummary({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      _SummaryItem(title: 'Projects', value: '0', icon: Icons.folder_outlined),
      _SummaryItem(title: 'Tasks', value: '0', icon: Icons.task_alt_outlined),
      _SummaryItem(
        title: 'Completed',
        value: '0',
        icon: Icons.check_circle_outline,
      ),
      _SummaryItem(title: 'Pending', value: '0', icon: Icons.schedule_outlined),
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

        return AppCard(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(item.icon, size: 22),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      item.value,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const Spacer(),

                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
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
