import 'package:flowtask/features/authentication/domain/entities/user_entity.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_controller_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = Provider<UserEntity?>((ref) {
  return ref.watch(authControllerProvider).user;
});
