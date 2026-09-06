import 'package:Ohtli/features/home/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.userName,
    required super.date,
    required super.content,
    required super.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id']?.toString() ?? '',
      userName: json['user_name'] ?? json['nombre_usuario'] ?? 'Anónimo',
      date: json['date'] ?? json['fecha'] ?? 'Reciente',
      content: json['content'] ?? json['contenido'] ?? '',
      rating: (json['rating'] ?? json['calificacion'] as num?)?.toDouble() ?? 5.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'date': date,
      'content': content,
      'rating': rating,
    };
  }
}
