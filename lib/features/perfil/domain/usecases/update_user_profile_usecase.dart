import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<Profile> call(String newName) async {
    if (newName.trim().isEmpty) {
      throw Exception('El nombre no puede estar vacío');
    }
    return await repository.updateProfileName(newName);
  }
}