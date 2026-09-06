class BadgeUnlocked {
  final String id;
  final String name;
  final String? iconUrl;
  final String description;
  final int requirementValue;

  const BadgeUnlocked({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.requirementValue,
  });
}