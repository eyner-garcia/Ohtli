import 'package:supabase_flutter/supabase_flutter.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {

  Future<UserEntity> loginWithEmail({
    required String email,
    required String password
  });
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String nombreCompleto
  });
  Future<void> sendPasswordResetCode(String email);
  Future<void> verifyOtp(String email, String token);
  Future<void> updatePassword(String newPassword);

  Future<void> signOut();

  Stream<AuthState> get authStateChanges;
}