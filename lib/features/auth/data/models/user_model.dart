import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.authId,
    required super.nombreCompleto,
    required super.correo,
    required super.rol,
    required super.xpAcumulada,
    required super.nivelActual,
    super.fotoPerfilUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      authId: json['auth_id'] as String,
      nombreCompleto: json['nombre_completo'] as String,
      correo: json['correo'] as String,
      rol: json['rol'] as String,
      xpAcumulada: json['xp_acumulada'] as int? ?? 0,
      nivelActual: json['nivel_actual'] as int? ?? 1,
      fotoPerfilUrl: json['foto_perfil_url'] as String?,
    );
  }

  @override
  UserModel copyWith({
    String? id,
    String? authId,
    String? nombreCompleto,
    String? correo,
    String? rol,
    int? xpAcumulada,
    int? nivelActual,
    String? fotoPerfilUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      authId: authId ?? this.authId,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      correo: correo ?? this.correo,
      rol: rol ?? this.rol,
      xpAcumulada: xpAcumulada ?? this.xpAcumulada,
      nivelActual: nivelActual ?? this.nivelActual,
      fotoPerfilUrl: fotoPerfilUrl ?? this.fotoPerfilUrl,
    );
  }
}