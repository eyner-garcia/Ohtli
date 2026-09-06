import '../../domain/entities/department_progress.dart';

class DepartmentProgressModel extends DepartmentProgress {
  const DepartmentProgressModel({
    required super.id,
    required super.completed,
    required super.completedNow,
    required super.currentPercentage,
    required super.previousPercentage,
  });

  factory DepartmentProgressModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DepartmentProgressModel(
      id: json['id'] as String,
      completed: json['completado'] as bool? ?? false,
      completedNow: json['completado_ahora'] as bool? ?? false,
      currentPercentage:
      json['porcentaje_actual'] as int? ?? 0,
      previousPercentage:
      json['porcentaje_anterior'] as int? ?? 0,
    );
  }
}