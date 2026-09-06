import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final SupabaseClient supabaseClient;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.supabaseClient,
  });

  @override
  Future<Profile> getUserProfile({
    bool forceRefresh = false,
  }) async {
    final authUser = supabaseClient.auth.currentUser;

    if (authUser == null) {
      throw Exception('Usuario no autenticado');
    }

    Profile? cachedProfile;

    //  Intentar leer cache
    try {
      cachedProfile = await localDataSource.getCachedProfile(authUser.id);
    } catch (_) {
      cachedProfile = null;
    }

    // Determinar si cache es válida
    final isCacheValid =
        cachedProfile != null &&
            cachedProfile.lastSyncedAt != null &&
            DateTime.now()
                .difference(cachedProfile.lastSyncedAt!)
                .inHours <
                24;

    if (!forceRefresh && isCacheValid) {
      return cachedProfile!;
    }

    final remoteProfile = await remoteDataSource.getProfile();

    try {
      await localDataSource.saveProfile(remoteProfile);
    } catch (_) {
    }

    return remoteProfile;
  }

  @override
  Future<Profile> updateProfileName(String newName) async {
    final authUser = supabaseClient.auth.currentUser;
    if (authUser == null) throw Exception('Usuario no autenticado');

    final currentProfile = await getUserProfile();

    await remoteDataSource.updateProfileName(
      userId: currentProfile.user.id,
      newName: newName,
    );

    final updatedUserModel = currentProfile.user.copyWith(nombreCompleto: newName);
    final updatedProfile = Profile(
      user: updatedUserModel,
      placesCount: currentProfile.placesCount,
      routesCount: currentProfile.routesCount,
      badgesCount: currentProfile.badgesCount,
      lastSyncedAt: DateTime.now(),
    );

    await localDataSource.saveProfile(updatedProfile);

    return updatedProfile;
  }

  @override
  Future<Profile> updateProfileAvatar(File imageFile) async {
    final authUser = supabaseClient.auth.currentUser;
    if (authUser == null) throw Exception('Usuario no autenticado');

    final currentProfile = await getUserProfile();

    // Subir a Supabase Storage
    final avatarUrl = await remoteDataSource.uploadAvatar(
      userId: currentProfile.user.id,
      imageFile: imageFile,
    );

    await remoteDataSource.updateProfileAvatar(
      userId: currentProfile.user.id,
      avatarUrl: avatarUrl,
    );

    final updatedUserModel = currentProfile.user.copyWith(fotoPerfilUrl: avatarUrl);
    final updatedProfile = Profile(
      user: updatedUserModel,
      placesCount: currentProfile.placesCount,
      routesCount: currentProfile.routesCount,
      badgesCount: currentProfile.badgesCount,
      lastSyncedAt: DateTime.now(),
    );

    await localDataSource.saveProfile(updatedProfile);

    return updatedProfile;
  }
}