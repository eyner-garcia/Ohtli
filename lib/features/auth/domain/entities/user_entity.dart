class UserEntity {
  final String id;
  final String authId;
  final String nombreCompleto;
  final String correo;
  final String rol;
  final int xpAcumulada;
  final int nivelActual;

  const UserEntity({
    required this.id,
    required this.authId,
    required this.nombreCompleto,
    required this.correo,
    required this.rol,
    required this.xpAcumulada,
    required this.nivelActual,
  });
}