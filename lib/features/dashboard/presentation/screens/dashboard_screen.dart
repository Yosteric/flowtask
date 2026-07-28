import 'package:flowtask/core/router/app_navigator.dart';
import 'package:flowtask/core/router/app_routes.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(authControllerProvider.notifier).signOut();

            if (context.mounted) {
              AppNavigator.go(context, AppRoutes.login);
            }
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
