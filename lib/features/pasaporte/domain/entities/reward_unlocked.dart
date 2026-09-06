import 'package:flutter/foundation.dart';

@immutable
class RewardUnlocked {
  final String id;
  final String title;
  final String? description;
  final String? benefitType;
  final String? benefitValue;
  final String? benefitDescription;
  final String? rewardFrequency;
  final DateTime? expiresAt;
  final String? redemptionCode;

  const RewardUnlocked({
    required this.id,
    required this.title,
    this.description,
    this.benefitType,
    this.benefitValue,
    this.benefitDescription,
    this.rewardFrequency,
    this.expiresAt,
    this.redemptionCode,
  });
}