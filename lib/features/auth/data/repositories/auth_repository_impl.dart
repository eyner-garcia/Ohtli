import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String nombreCompleto,
  }) {
    return _remoteDataSource.signUp(email: email, password: password, nombreCompleto: nombreCompleto);
  }

  @override
  Future<void> sendPasswordResetCode(String email) async {
    await _remoteDataSource.sendPasswordResetCode(email);
  }

  @override
  Future<void> verifyOtp(String email, String token) async {
    await _remoteDataSource.verifyOtp(email, token);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _remoteDataSource.updatePassword(newPassword);
  }

  @override
  Future<void> signOut() => _remoteDataSource.signOut();

  @override
  Stream<AuthState> get authStateChanges => _remoteDataSource.authStateChanges;
}