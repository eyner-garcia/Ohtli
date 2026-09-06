class DestinationEntity {
  final String id;
  final String title;
  final String location;
  final double rating;
  final int reviewsCount;
  final String description;
  final String distance;
  final List<String> gallery;

  DestinationEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.rating,
    this.reviewsCount = 0,
    this.description = '',
    this.distance = '',
    this.gallery = const [],
  });
}
