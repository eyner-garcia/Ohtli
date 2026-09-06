import '../../domain/entities/reward_unlocked.dart';

class RewardUnlockedModel extends RewardUnlocked {
  const RewardUnlockedModel({
    required super.id,
    required super.title,
    super.description,
    super.benefitType,
    super.benefitValue,
    super.benefitDescription,
    super.rewardFrequency,
    super.expiresAt,
    super.redemptionCode,
  });

  factory RewardUnlockedModel.fromJson(Map<String, dynamic> json) {
    return RewardUnlockedModel(
      id: json['id'].toString(),
      title: json['titulo']?.toString() ?? 'Recompensa Ohtli',
      description: json['descripcion']?.toString(),
      benefitType: json['tipo_beneficio']?.toString(),
      benefitValue: json['valor_beneficio']?.toString(),
      benefitDescription: json['descripcion_beneficio']?.toString(),
      rewardFrequency: json['frecuencia_recompensa']?.toString(),
      expiresAt: json['expira_en'] == null
          ? null
          : DateTime.tryParse(json['expira_en'].toString()),
      redemptionCode: json['codigo_canje']?.toString(),
    );
  }
}
