import 'package:flowtask/features/authentication/domain/entities/user_entity.dart';
import 'package:flowtask/features/authentication/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity?> call() {
    return _repository.getCurrentUser();
  }
}
