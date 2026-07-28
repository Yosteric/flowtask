import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning 👋', style: theme.textTheme.bodyMedium),
              SizedBox(height: AppSpacing.xs),
              Text(userName, style: theme.textTheme.headlineSmall),
            ],
          ),
        ),
        const CircleAvatar(radius: 24, child: Icon(Icons.person)),
      ],
    );
  }
}
