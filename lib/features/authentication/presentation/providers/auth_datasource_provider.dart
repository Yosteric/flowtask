import 'package:flowtask/core/di/dependency_injection.dart';
import 'package:flowtask/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flowtask/features/authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.read(firebaseAuthProvider));
});
