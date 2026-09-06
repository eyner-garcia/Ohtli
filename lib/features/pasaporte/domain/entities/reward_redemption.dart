import 'reward_unlocked.dart';

class RewardRedemption {
  final String id;
  final String status;
  final String redemptionCode;
  final DateTime? expiresAt;
  final DateTime? usedAt;
  final DateTime createdAt;
  final RewardUnlocked reward;

  const RewardRedemption({
    required this.id,
    required this.status,
    required this.redemptionCode,
    required this.expiresAt,
    required this.usedAt,
    required this.createdAt,
    required this.reward,
  });

  bool get isAvailable => status == 'disponible';
  bool get isUsed => status == 'utilizado' || status == 'canjeado';
}
