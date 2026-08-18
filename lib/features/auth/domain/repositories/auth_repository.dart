import 'package:supabase_flutter/supabase_flutter.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();
  Stream<AuthState> get authStateChanges;
}