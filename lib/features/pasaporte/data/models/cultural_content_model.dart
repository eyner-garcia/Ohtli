import '../../domain/entities/cultural_content.dart';

class CulturalContentModel extends CulturalContent {
  const CulturalContentModel({
    required super.id,
    required super.title,
    required super.description,
    required super.contentType,
    required super.imageUrl,
    required super.requirementPercentage,
    required super.order,
    required super.isIntroductory,
  });

  factory CulturalContentModel.fromJson(Map<String, dynamic> json) {
    return CulturalContentModel(
      id: json['id'] as String,
      title: json['titulo'] as String,
      description: json['descripcion'] as String,
      contentType: json['tipo_contenido'] as String,
      imageUrl: json['imagen_url'] as String?,
      requirementPercentage: json['requisito_porcentaje'] as int,
      order: json['orden'] as int,
      isIntroductory: json['es_introductorio'] as bool,
    );
  }
}