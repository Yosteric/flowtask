import 'package:flowtask/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flowtask/features/authentication/domain/entities/user_entity.dart';
import 'package:flowtask/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<UserEntity?> getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }

  @override
  Future<UserEntity> signInAnonymously() {
    return _remoteDataSource.signInAnonymously();
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }
}
