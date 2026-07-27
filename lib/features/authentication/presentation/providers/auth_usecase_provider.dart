import 'package:flowtask/features/authentication/domain/usecases/get_current_user_use_case.dart';
import 'package:flowtask/features/authentication/domain/usecases/sign_in_anonymously_use_case.dart';
import 'package:flowtask/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.read(authRepositoryProvider));
});

final signInAnonymouslyUseCaseProvider = Provider<SignInAnonymouslyUseCase>((
  ref,
) {
  return SignInAnonymouslyUseCase(ref.read(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.read(authRepositoryProvider));
});
