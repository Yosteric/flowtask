import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowtask/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flowtask/features/authentication/data/models/user_model.dart';
import 'package:flowtask/features/authentication/domain/entities/user_entity.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    final credential = await _firebaseAuth.signInAnonymously();

    final user = credential.user;

    if (user == null) {
      throw Exception('Anonymous sign in failed.');
    }

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
