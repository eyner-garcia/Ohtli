import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  Future<Profile> call({bool forceRefresh = false}) async {
    return await repository.getUserProfile(forceRefresh: forceRefresh);
  }
}