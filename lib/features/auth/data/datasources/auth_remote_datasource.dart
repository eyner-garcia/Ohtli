import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSource(this._client);

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const FormatException('No se pudo recuperar la información del usuario.');
      }

      final data = await _client
          .from('usuarios')
          .select()
          .eq('auth_id', response.user!.id)
          .single();

      return UserModel.fromJson(data);
    } on AuthException catch (e) {
      if (e.message.contains('Invalid login credentials')) {
        throw 'Correo o contraseña incorrectos.';
      }
      throw e.message;
    } catch (e) {
      throw 'Ocurrió un error inesperado al iniciar sesión.';
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String nombreCompleto,
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {'nombre_completo': nombreCompleto},
    );
  }

  Future<void> sendPasswordResetCode(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  Future<void> verifyOtp(String email, String token) async {
    await _client.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.recovery,
    );
  }

  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }


  Future<void> signOut() => _client.auth.signOut();
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}