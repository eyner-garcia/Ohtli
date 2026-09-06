class UserEntity {
  final String id;
  final String authId;
  final String nombreCompleto;
  final String correo;
  final String rol;
  final int xpAcumulada;
  final int nivelActual;
  final String? fotoPerfilUrl;

  const UserEntity({
    required this.id,
    required this.authId,
    required this.nombreCompleto,
    required this.correo,
    required this.rol,
    required this.xpAcumulada,
    required this.nivelActual,
    this.fotoPerfilUrl,
  });

  UserEntity copyWith({
    String? id,
    String? authId,
    String? nombreCompleto,
    String? correo,
    String? rol,
    int? xpAcumulada,
    int? nivelActual,
    String? fotoPerfilUrl,
  }) {
    return UserEntity(
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