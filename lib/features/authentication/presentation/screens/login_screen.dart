import 'package:flowtask/features/authentication/presentation/providers/auth_controller_provider.dart';
import 'package:flowtask/features/authentication/presentation/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Center(
        child: switch (authState.status) {
          AuthStatus.loading => const CircularProgressIndicator(),

          AuthStatus.authenticated => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 64),
              const SizedBox(height: 16),
              Text('Welcome ${authState.user?.name ?? 'Anonymous'}'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signOut();
                },
                child: const Text('Sign out'),
              ),
            ],
          ),

          AuthStatus.error => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(authState.errorMessage ?? 'Unknown error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signInAnonymously();
                },
                child: const Text('Try again'),
              ),
            ],
          ),

          _ => ElevatedButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).signInAnonymously();
            },
            child: const Text('Continue anonymously'),
          ),
        },
      ),
    );
  }
}
