import '../../domain/entities/pasaporte_entity.dart';

class PasaporteModel extends PasaporteEntity {
  PasaporteModel({
    required super.id,
    required super.name,
  });

  factory PasaporteModel.fromJson(Map<String, dynamic> json) {
    return PasaporteModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
