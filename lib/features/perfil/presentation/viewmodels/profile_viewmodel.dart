import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/app_database.dart';
import '../../data/datasources/profile_local_datasource.dart';
import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_profile_avatar_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';

part 'profile_viewmodel.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final supabaseClient = Supabase.instance.client;
  final db = ref.watch(databaseProvider);

  return ProfileRepositoryImpl(
    remoteDataSource: ProfileRemoteDataSourceImpl(supabaseClient),
    localDataSource: ProfileLocalDataSourceImpl(db),
    supabaseClient: supabaseClient,
  );
}

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  late GetUserProfile _getUserProfile;
  late UpdateUserProfileUseCase _updateUserProfileUseCase;
  late UpdateProfileAvatarUseCase _updateProfileAvatarUseCase;

  @override
  FutureOr<Profile> build() async {
    final repository = ref.watch(profileRepositoryProvider);
    _getUserProfile = GetUserProfile(repository);
    _updateUserProfileUseCase = UpdateUserProfileUseCase(repository);
    _updateProfileAvatarUseCase = UpdateProfileAvatarUseCase(repository);

    return await _getUserProfile();
  }

  Future<void> refreshProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
          () => _getUserProfile(forceRefresh: true),
    );
  }
  Future<void> updateProfile({String? newName, File? imageFile}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (imageFile != null) {
        await _updateProfileAvatarUseCase(imageFile);
      }

      if (newName != null && newName.isNotEmpty) {
        await _updateUserProfileUseCase(newName);
      }

      return await _getUserProfile(forceRefresh: true);
    });
  }
}