import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/profile.dart';

abstract class ProfileLocalDataSource {
  Future<Profile?> getCachedProfile(String authId);
  Future<void> saveProfile(Profile profile);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final AppDatabase db;

  ProfileLocalDataSourceImpl(this.db);

  @override
  Future<Profile?> getCachedProfile(String authId) async {
    final query = db.select(db.localUsuarios)
      ..where((tbl) => tbl.authId.equals(authId));
    final localUser = await query.getSingleOrNull();

    if (localUser == null) return null;

    final userModel = UserModel(
      id: localUser.id,
      authId: localUser.authId,
      nombreCompleto: localUser.nombreCompleto,
      correo: localUser.correo,
      rol: localUser.rol,
      xpAcumulada: localUser.xpAcumulada,
      nivelActual: localUser.nivelActual,
      fotoPerfilUrl: localUser
          .fotoPerfilUrl,
    );

    return Profile(
      user: userModel,
      placesCount: localUser.placesCount,
      routesCount: localUser.routesCount,
      badgesCount: localUser.badgesCount,
      lastSyncedAt: localUser.lastSyncedAt,
    );
  }

  @override
  Future<void> saveProfile(Profile profile) async {
    final entry = LocalUsuariosCompanion(
      id: Value(profile.user.id),
      authId: Value(profile.user.authId),
      nombreCompleto: Value(profile.user.nombreCompleto),
      correo: Value(profile.user.correo),
      rol: Value(profile.user.rol),
      fotoPerfilUrl: Value(profile.user.fotoPerfilUrl),
      xpAcumulada: Value(profile.user.xpAcumulada),
      nivelActual: Value(profile.user.nivelActual),
      placesCount: Value(profile.placesCount),
      routesCount: Value(profile.routesCount),
      badgesCount: Value(profile.badgesCount),
      lastSyncedAt: Value(DateTime.now()),
    );

    await db.into(db.localUsuarios).insert(
      entry,
      onConflict: DoUpdate(
            (old) => entry,
        target: [db.localUsuarios.id],
      ),
    );
  }

}