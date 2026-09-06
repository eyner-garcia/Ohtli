import '../../domain/entities/cultural_content_unlock.dart';
import 'cultural_content_model.dart';

class CulturalContentUnlockModel extends CulturalContentUnlock {
  const CulturalContentUnlockModel({
    required super.unlocked,
    required super.quantity,
    required super.contents,
  });

  factory CulturalContentUnlockModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final contentsJson =
        (json['contenidos'] as List<dynamic>?) ?? [];

    return CulturalContentUnlockModel(
      unlocked: json['desbloqueado'] as bool? ?? false,
      quantity: json['cantidad'] as int? ?? 0,
      contents: contentsJson
          .map(
            (item) => CulturalContentModel.fromJson(
          Map<String, dynamic>.from(item as Map),
        ),
      )
          .toList(),
    );
  }
}