import 'package:flowtask/features/authentication/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<UserEntity?> getCurrentUser();

  Future<UserEntity> signInAnonymously();

  Future<void> signOut();
}
