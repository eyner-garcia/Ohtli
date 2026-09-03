import '../../../auth/data/models/user_model.dart';

class Profile {
  final UserModel user;
  final int placesCount;
  final int routesCount;
  final int badgesCount;
  final DateTime? lastSyncedAt;

  Profile({
    required this.user,
    required this.placesCount,
    required this.routesCount,
    required this.badgesCount,
    this.lastSyncedAt,
  });
}