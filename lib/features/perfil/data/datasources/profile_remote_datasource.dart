import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfile();
  Future<void> updateProfileName({required String userId, required String newName});
  Future<String> uploadAvatar({required String userId, required File imageFile});
  Future<void> updateProfileAvatar({required String userId, required String avatarUrl});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<Profile> getProfile() async {
    final authUser = supabaseClient.auth.currentUser;
    if (authUser == null) {
      throw Exception('Usuario no autenticado');
    }

    final userResponse = await supabaseClient
        .from('usuarios')
        .select()
        .eq('auth_id', authUser.id)
        .single();

    final userModel = UserModel.fromJson(userResponse);

    final results = await Future.wait([
      supabaseClient
          .from('pasaporte_sellos')
          .select()
          .eq('usuario_id', userModel.id)
          .count(CountOption.exact),
      supabaseClient
          .from('usuarios_rutas')
          .select()
          .eq('usuario_id', userModel.id)
          .count(CountOption.exact),
      supabaseClient
          .from('usuarios_insignias')
          .select()
          .eq('usuario_id', userModel.id)
          .count(CountOption.exact),
    ]);

    return Profile(
      user: userModel,
      placesCount: results[0].count,
      routesCount: results[1].count,
      badgesCount: results[2].count,
    );
  }

  @override
  Future<void> updateProfileName({required String userId, required String newName}) async {
    await supabaseClient
        .from('usuarios')
        .update({'nombre_completo': newName})
        .eq('id', userId);
  }

  @override
  Future<String> uploadAvatar({required String userId, required File imageFile}) async {
    final fileExt = imageFile.path.split('.').last;
    final filePath = '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

    await supabaseClient.storage.from('avatars').upload(
      filePath,
      imageFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
    );

    return supabaseClient.storage.from('avatars').getPublicUrl(filePath);
  }

  @override
  Future<void> updateProfileAvatar({required String userId, required String avatarUrl}) async {
    await supabaseClient
        .from('usuarios')
        .update({'foto_perfil_url': avatarUrl})
        .eq('id', userId);
  }
}