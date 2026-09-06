import 'dart:io';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileAvatarUseCase {
  final ProfileRepository repository;

  UpdateProfileAvatarUseCase(this.repository);

  Future<Profile> call(File imageFile) async {
    return await repository.updateProfileAvatar(imageFile);
  }
}