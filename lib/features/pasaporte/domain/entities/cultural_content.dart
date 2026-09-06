class CulturalContent {
  final String id;
  final String title;
  final String description;
  final String contentType;
  final String? imageUrl;
  final int requirementPercentage;
  final int order;
  final bool isIntroductory;

  const CulturalContent({
    required this.id,
    required this.title,
    required this.description,
    required this.contentType,
    required this.imageUrl,
    required this.requirementPercentage,
    required this.order,
    required this.isIntroductory,
  });
}