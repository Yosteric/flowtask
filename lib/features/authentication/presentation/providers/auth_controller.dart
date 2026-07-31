import 'package:flowtask/features/authentication/domain/entities/user_entity.dart';
import 'package:flowtask/features/authentication/domain/usecases/get_current_user_use_case.dart';
import 'package:flowtask/features/authentication/domain/usecases/sign_in_anonymously_use_case.dart';
import 'package:flowtask/features/authentication/domain/usecases/sign_out_use_case.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_usecase_provider.dart';
import 'package:flowtask/features/authentication/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends Notifier<AuthState> {
  late final GetCurrentUserUseCase _getCurrentUser;
  late final SignInAnonymouslyUseCase _signInAnonymously;
  late final SignOutUseCase _signOut;

  @override
  AuthState build() {
    _getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
    _signInAnonymously = ref.read(signInAnonymouslyUseCaseProvider);
    _signOut = ref.read(signOutUseCaseProvider);

    _initialize();

    return const AuthState();
  }

  Future<void> _initialize() async {
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
      final UserEntity user = await _signInAnonymously();

      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    await _signOut();

    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }
}
