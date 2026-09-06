import 'badge_unlocked.dart';
import 'cultural_content_unlock.dart';
import 'department_progress.dart';
import 'reward_unlocked.dart';

class StampPassportResult {
  final bool success;
  final String code;
  final String? message;

  final String? stampId;
  final String? poiId;
  final String? redemptionId;

  final int xpEarned;
  final int totalXp;

  final bool firstVisit;

  final bool rewardUnlocked;
  final RewardUnlocked? reward;

  final int totalVisits;
  final List<BadgeUnlocked> newBadges;

  final CulturalContentUnlock culturalContent;

  final DepartmentProgress? department;

  const StampPassportResult({
    required this.success,
    required this.code,
    required this.message,
    required this.stampId,
    required this.poiId,
    required this.redemptionId,
    required this.xpEarned,
    required this.totalXp,
    required this.firstVisit,
    required this.rewardUnlocked,
    required this.reward,
    required this.totalVisits,
    required this.newBadges,
    required this.culturalContent,
    required this.department,
  });
}