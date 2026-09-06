import '../../domain/entities/badge_unlocked.dart';

class BadgeUnlockedModel extends BadgeUnlocked {
  const BadgeUnlockedModel({
    required super.id,
    required super.name,
    required super.iconUrl,
    required super.description,
    required super.requirementValue,
  });

  factory BadgeUnlockedModel.fromJson(Map<String, dynamic> json) {
    return BadgeUnlockedModel(
      id: json['id'] as String,
      name: json['nombre'] as String,
      iconUrl: json['icono_url'] as String?,
      description: json['descripcion'] as String,
      requirementValue: json['valor_requisito'] as int,
    );
  }
}