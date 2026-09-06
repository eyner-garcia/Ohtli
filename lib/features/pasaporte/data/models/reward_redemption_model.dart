import '../../domain/entities/reward_redemption.dart';
import 'reward_unlocked_model.dart';

class RewardRedemptionModel extends RewardRedemption {
  const RewardRedemptionModel({
    required super.id,
    required super.status,
    required super.redemptionCode,
    required super.expiresAt,
    required super.usedAt,
    required super.createdAt,
    required super.reward,
  });

  factory RewardRedemptionModel.fromJson(Map<String, dynamic> json) {
    final rewardJson = Map<String, dynamic>.from(json['regalias'] as Map);
    rewardJson['codigo_canje'] = json['codigo_canje'];
    rewardJson['expira_en'] = json['expira_en'] ?? rewardJson['expira_en'];

    return RewardRedemptionModel(
      id: json['id'] as String,
      status: json['estado'].toString(),
      redemptionCode: json['codigo_canje'].toString(),
      expiresAt: json['expira_en'] == null
          ? null
          : DateTime.tryParse(json['expira_en'].toString()),
      usedAt: json['utilizada_en'] == null
          ? null
          : DateTime.tryParse(json['utilizada_en'].toString()),
      createdAt: DateTime.parse(json['creado_en'].toString()),
      reward: RewardUnlockedModel.fromJson(rewardJson),
    );
  }
}
