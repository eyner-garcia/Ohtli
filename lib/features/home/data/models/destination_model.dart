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
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviews_count'] ?? 0,
      description: json['description'] ?? '',
      distance: json['distance'] ?? '',
      gallery: List<String>.from(json['gallery'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'rating': rating,
      'reviews_count': reviewsCount,
      'description': description,
      'distance': distance,
      'gallery': gallery,
    };
  }
}
