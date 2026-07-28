import 'package:flowtask/features/authentication/presentation/providers/auth_controller.dart';
import 'package:flowtask/features/authentication/presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
