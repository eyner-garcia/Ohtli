class DestinationEntity {
  final String id;
  final String title;
  final String location;
  final double rating;
  final int reviewsCount;
  final String description;
  final String distance;
  final List<String> gallery;
  final String imageUrl;
  final double? latitude;
  final double? longitude;
  final int? categoryId;

  DestinationEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.rating,
    this.reviewsCount = 0,
    this.description = '',
    this.distance = '',
    this.gallery = const [],
    this.imageUrl = '',
    this.latitude,
    this.longitude,
    this.categoryId,
  });
}
