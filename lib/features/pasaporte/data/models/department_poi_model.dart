import '../../domain/entities/department_poi.dart';

class DepartmentPoiModel extends DepartmentPoi {
  const DepartmentPoiModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    required super.coverPhotoUrl,
    required super.rating,
    required super.reviewCount,
    required super.visited,
  });

  factory DepartmentPoiModel.fromJson(
    Map<String, dynamic> json, {
    required bool visited,
  }) {
    return DepartmentPoiModel(
      id: json['id'].toString(),
      name: json['nombre']?.toString() ?? 'Punto de interés',
      description: json['descripcion']?.toString() ?? '',
      address: json['direccion']?.toString(),
      coverPhotoUrl: json['foto_portada_url']?.toString(),
      rating: _toDouble(json['promedio_calificacion']),
      reviewCount: _toInt(json['total_resenas']),
      visited: visited,
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
