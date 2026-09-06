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
    final poiPhotos = json['poi_fotos'];
    final orderedPhotos = <Map<String, dynamic>>[];

    if (poiPhotos is List) {
      for (final item in poiPhotos) {
        if (item is Map) {
          orderedPhotos.add(Map<String, dynamic>.from(item));
        }
      }
      orderedPhotos.sort(
        (a, b) => ((a['orden'] as num?)?.toInt() ?? 0)
            .compareTo((b['orden'] as num?)?.toInt() ?? 0),
      );
    }

    final relatedGallery = orderedPhotos
        .map((item) => item['foto_url']?.toString() ?? '')
        .where((url) => url.isNotEmpty)
        .toList();

    final rawGallery = json['gallery'] ?? json['galeria'];
    final gallery = rawGallery is List
        ? rawGallery
            .map((item) => item?.toString() ?? '')
            .where((url) => url.isNotEmpty)
            .toList()
        : relatedGallery;

    final cover = (json['foto_portada_url'] ??
            json['image_url'] ??
            (relatedGallery.isNotEmpty ? relatedGallery.first : ''))
        .toString();

    final distanceValue = json['distancia'];

    return DestinationModel(
      id: json['id']?.toString() ?? '',
      title: (json['nombre'] ?? json['title'] ?? '').toString(),
      location: (json['direccion'] ?? json['location'] ?? '').toString(),
      rating: (json['promedio_calificacion'] ?? json['rating'] as num?)
              ?.toDouble() ??
          0.0,
      reviewsCount:
          (json['total_resenas'] ?? json['reviews_count'] as num?)?.toInt() ?? 0,
      description:
          (json['descripcion'] ?? json['description'] ?? '').toString(),
      distance: distanceValue != null
          ? '${double.parse(distanceValue.toString()).toStringAsFixed(1)} km'
          : (json['distance'] ?? '').toString(),
      gallery: gallery.isNotEmpty ? gallery : relatedGallery,
      imageUrl: cover,
      latitude: (json['latitud'] as num?)?.toDouble(),
      longitude: (json['longitud'] as num?)?.toDouble(),
      categoryId: (json['categoria_id'] as num?)?.toInt(),
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
