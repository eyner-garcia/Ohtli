import '../../domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.id,
    required super.title,
    required super.description,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
