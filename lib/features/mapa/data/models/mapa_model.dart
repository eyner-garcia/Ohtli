import '../../domain/entities/mapa_entity.dart';

class MapaModel extends MapaEntity {
  MapaModel({
    required super.id,
    required super.latitude,
    required super.longitude,
  });

  factory MapaModel.fromJson(Map<String, dynamic> json) {
    return MapaModel(
      id: json['id'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
