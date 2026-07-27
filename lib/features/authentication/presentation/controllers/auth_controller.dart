import 'package:flowtask/features/authentication/domain/usecases/get_current_user_use_case.dart';
import 'package:flowtask/features/authentication/domain/usecases/sign_in_anonymously_use_case.dart';
import 'package:flowtask/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_usecase_provider.dart';
import 'package:flowtask/features/authentication/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  GetCurrentUserUseCase get _getCurrentUser =>
      ref.read(getCurrentUserUseCaseProvider);

  SignInAnonymouslyUseCase get _signIn =>
      ref.read(signInAnonymouslyUseCaseProvider);

  SignOutUseCase get _signOut => ref.read(signOutUseCaseProvider);

  Future<void> checkAuthentication() async {
    state = state.copyWith(status: AuthStatus.loading);

    final user = await _getCurrentUser();

    if (user == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
      return;
    }

    state = state.copyWith(status: AuthStatus.authenticated, user: user);
  }

  Future<void> signInAnonymously() async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final user = await _signIn();

      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    await _signOut();

    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }
}
