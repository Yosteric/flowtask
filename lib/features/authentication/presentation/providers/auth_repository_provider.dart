import 'package:flowtask/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:flowtask/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flowtask/features/authentication/presentation/providers/auth_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});
