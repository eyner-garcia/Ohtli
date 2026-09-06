import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../../../../core/errors/supabase_error_handler.dart';
import '../../../../core/errors/exceptions.dart';

class AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSource(this._client);

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    return supabaseCallHandler(() async {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('No se pudo recuperar la información del usuario.');
      }

      final data = await _client
          .from('usuarios')
          .select()
          .eq('auth_id', response.user!.id)
          .single();

      return UserModel.fromJson(data);
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String nombreCompleto,
  }) async {
    return supabaseCallHandler(() async {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {'nombre_completo': nombreCompleto},
      );
    });
  }

  Future<void> sendPasswordResetCode(String email) async {
    return supabaseCallHandler(() async {
      await _client.auth.resetPasswordForEmail(email);
    });
  }

  Future<void> verifyOtp(String email, String token) async {
    return supabaseCallHandler(() async {
      await _client.auth.verifyOTP(
        email: email,
        token: token,
        type: OtpType.recovery,
      );
    });
  }

  Future<void> updatePassword(String newPassword) async {
    return supabaseCallHandler(() async {
      await _client.auth.updateUser(UserAttributes(password: newPassword));
    });
  }

  Future<void> signOut() => _client.auth.signOut();

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}