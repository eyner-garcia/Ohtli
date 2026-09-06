import '../../domain/entities/map_point_entity.dart';

class MapPointModel extends MapPointEntity {
  MapPointModel({
    required super.id,
    required super.title,
    required super.description,
    required super.latitude,
    required super.longitude,
    super.imageUrl,
    super.category,
  });

  factory MapPointModel.fromJson(Map<String, dynamic> json) {
    return MapPointModel(
      id: json['id']?.toString() ?? '',
      title: json['nombre'] ?? json['title'] ?? '',
      description: json['descripcion'] ?? json['description'] ?? '',
      latitude: (json['latitud'] ?? json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitud'] ?? json['longitude'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['foto_portada_url'] ?? json['image_url'] ?? '',
      category: json['categoria'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': title,
      'descripcion': description,
      'latitud': latitude,
      'longitud': longitude,
      'foto_portada_url': imageUrl,
      'categoria': category,
    };
  }
}
