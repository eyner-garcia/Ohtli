import '../../domain/entities/stamp_passport_result.dart';
import 'badge_unlocked_model.dart';
import 'cultural_content_unlock_model.dart';
import 'department_progress_model.dart';
import 'reward_unlocked_model.dart';

class StampPassportResultModel extends StampPassportResult {
  const StampPassportResultModel({
    required super.success,
    required super.code,
    required super.message,
    required super.stampId,
    required super.poiId,
    required super.redemptionId,
    required super.xpEarned,
    required super.totalXp,
    required super.firstVisit,
    required super.rewardUnlocked,
    required super.reward,
    required super.totalVisits,
    required super.newBadges,
    required super.culturalContent,
    required super.department,
  });

  factory StampPassportResultModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final badgesJson =
    (json['insignias'] as Map?)?.cast<String, dynamic>();

    final badgesList =
        (badgesJson?['nuevas_insignias'] as List<dynamic>?) ?? [];

    final culturalJson =
        (json['contenido_cultural'] as Map?)
            ?.cast<String, dynamic>() ??
            {
              'desbloqueado': false,
              'cantidad': 0,
              'contenidos': [],
            };

    final departmentJson =
    (json['departamento'] as Map?)
        ?.cast<String, dynamic>();

    final rewardJson =
    (json['recompensa'] as Map?)
        ?.cast<String, dynamic>();

    return StampPassportResultModel(
      success: json['success'] as bool? ?? false,

      code: json['codigo'] as String? ?? '',

      message: json['mensaje'] as String?,

      stampId: json['sello_id'] as String?,

      poiId: json['poi_id'] as String?,

      redemptionId: json['canje_id'] as String?,

      xpEarned: json['xp_ganada'] as int? ?? 0,

      totalXp: json['xp_total'] as int? ?? 0,

      firstVisit: json['primera_visita'] as bool? ?? false,

      rewardUnlocked:
      json['recompensa_desbloqueada'] as bool? ?? false,

      reward: rewardJson != null
          ? RewardUnlockedModel.fromJson(rewardJson)
          : null,

      totalVisits:
      badgesJson?['visitas_totales'] as int? ?? 0,

      newBadges: badgesList
          .map(
            (item) => BadgeUnlockedModel.fromJson(
          Map<String, dynamic>.from(item as Map),
        ),
      )
          .toList(),

      culturalContent:
      CulturalContentUnlockModel.fromJson(culturalJson),

      department: departmentJson != null
          ? DepartmentProgressModel.fromJson(
        departmentJson,
      )
          : null,
    );
  }
}