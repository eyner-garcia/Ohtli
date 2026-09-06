import 'cultural_content.dart';

class PassportSnapshot {
  final String userName;
  final String? photoUrl;
  final int xpTotal;
  final int totalStamps;
  final List<PassportDepartmentSnapshot> departments;
  final List<PassportBadgeSnapshot> badges;
  final List<CulturalContent> culturalContents;

  const PassportSnapshot({
    required this.userName,
    required this.photoUrl,
    required this.xpTotal,
    required this.totalStamps,
    required this.departments,
    required this.badges,
    required this.culturalContents,
  });
}

class PassportDepartmentSnapshot {
  final String id;
  final String name;
  final int percentage;
  final bool completed;
  final int visits;
  final int discoveries;

  const PassportDepartmentSnapshot({
    required this.id,
    required this.name,
    required this.percentage,
    required this.completed,
    required this.visits,
    required this.discoveries,
  });
}

class PassportBadgeSnapshot {
  final String id;
  final String name;
  final String description;
  final String? iconUrl;
  final int requirementValue;
  final bool unlocked;

  const PassportBadgeSnapshot({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.requirementValue,
    required this.unlocked,
  });
}
