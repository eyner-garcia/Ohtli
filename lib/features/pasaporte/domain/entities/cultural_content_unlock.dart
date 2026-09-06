import 'cultural_content.dart';

class CulturalContentUnlock {
  final bool unlocked;
  final int quantity;
  final List<CulturalContent> contents;

  const CulturalContentUnlock({
    required this.unlocked,
    required this.quantity,
    required this.contents,
  });
}