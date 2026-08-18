import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSource(this._client);

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw const AuthException('Credenciales inválidas');
    }

    final data = await _client
        .from('usuarios')
        .select()
        .eq('auth_id', response.user!.id)
        .single();

    return UserModel.fromJson(data);
  }

  Future<void> signOut() => _client.auth.signOut();
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}