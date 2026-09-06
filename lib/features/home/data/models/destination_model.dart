import 'package:Ohtli/features/home/domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  DestinationModel({
    required super.id,
    required super.title,
    required super.location,
    required super.rating,
    super.reviewsCount,
    super.description,
    super.distance,
    super.gallery,
    super.imageUrl,
    super.latitude,
    super.longitude,
    super.categoryId,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id']?.toString() ?? '',
      title: json['nombre'] ?? json['title'] ?? '',
      location: json['direccion'] ?? json['location'] ?? '',
      rating: (json['promedio_calificacion'] ?? json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['total_resenas'] ?? json['reviews_count'] ?? 0,
      description: json['descripcion'] ?? json['description'] ?? '',
      distance: json['distancia'] != null ? '${double.parse(json['distancia'].toString()).toStringAsFixed(1)} km' : (json['distance'] ?? ''),
      gallery: List<String>.from(json['gallery'] ?? json['galeria'] ?? []),
      imageUrl: json['foto_portada_url'] ?? json['image_url'] ?? '',
      latitude: (json['latitud'] as num?)?.toDouble(),
      longitude: (json['longitud'] as num?)?.toDouble(),
      categoryId: json['categoria_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': title,
      'direccion': location,
      'promedio_calificacion': rating,
      'total_resenas': reviewsCount,
      'descripcion': description,
      'foto_portada_url': imageUrl,
      'latitud': latitude,
      'longitud': longitude,
      'categoria_id': categoryId,
    };
  }
}
