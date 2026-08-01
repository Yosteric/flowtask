import 'package:flowtask/core/theme/app_spacing.dart';
import 'package:flowtask/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:flowtask/features/dashboard/presentation/widgets/dashboard_summary.dart';
import 'package:flowtask/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/projects');
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(userName: 'Yostin'),

              const SizedBox(height: AppSpacing.xl),

              const DashboardSummary(),

              const SizedBox(height: AppSpacing.xxl),

              const SectionTitle(title: 'Today\'s Tasks'),

              const SizedBox(height: AppSpacing.md),

              const EmptyState(
                title: 'No tasks yet',
                message: 'Create your first task to get started.',
              ),

              const SizedBox(height: AppSpacing.xxl),

              const SectionTitle(title: 'Recent Projects'),

              const SizedBox(height: AppSpacing.md),

              const EmptyState(
                title: 'No projects yet',
                message: 'Your recent projects will appear here.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
