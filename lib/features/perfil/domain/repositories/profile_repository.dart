import 'dart:io';

import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getUserProfile({bool forceRefresh = false});
  Future<Profile> updateProfileName(String newName);
  Future<Profile> updateProfileAvatar(File imageFile);
}