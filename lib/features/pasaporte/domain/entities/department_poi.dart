class DepartmentPoi {
  final String id;
  final String name;
  final String description;
  final String? address;
  final String? coverPhotoUrl;
  final double rating;
  final int reviewCount;
  final bool visited;

  const DepartmentPoi({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.coverPhotoUrl,
    required this.rating,
    required this.reviewCount,
    required this.visited,
  });
}
