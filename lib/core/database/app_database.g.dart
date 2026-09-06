// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalUsuariosTable extends LocalUsuarios
    with TableInfo<$LocalUsuariosTable, LocalUsuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authIdMeta = const VerificationMeta('authId');
  @override
  late final GeneratedColumn<String> authId = GeneratedColumn<String>(
      'auth_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreCompletoMeta =
      const VerificationMeta('nombreCompleto');
  @override
  late final GeneratedColumn<String> nombreCompleto = GeneratedColumn<String>(
      'nombre_completo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correoMeta = const VerificationMeta('correo');
  @override
  late final GeneratedColumn<String> correo = GeneratedColumn<String>(
      'correo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fotoPerfilUrlMeta =
      const VerificationMeta('fotoPerfilUrl');
  @override
  late final GeneratedColumn<String> fotoPerfilUrl = GeneratedColumn<String>(
      'foto_perfil_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _xpAcumuladaMeta =
      const VerificationMeta('xpAcumulada');
  @override
  late final GeneratedColumn<int> xpAcumulada = GeneratedColumn<int>(
      'xp_acumulada', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _nivelActualMeta =
      const VerificationMeta('nivelActual');
  @override
  late final GeneratedColumn<int> nivelActual = GeneratedColumn<int>(
      'nivel_actual', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _placesCountMeta =
      const VerificationMeta('placesCount');
  @override
  late final GeneratedColumn<int> placesCount = GeneratedColumn<int>(
      'places_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _routesCountMeta =
      const VerificationMeta('routesCount');
  @override
  late final GeneratedColumn<int> routesCount = GeneratedColumn<int>(
      'routes_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _badgesCountMeta =
      const VerificationMeta('badgesCount');
  @override
  late final GeneratedColumn<int> badgesCount = GeneratedColumn<int>(
      'badges_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        authId,
        nombreCompleto,
        correo,
        rol,
        fotoPerfilUrl,
        xpAcumulada,
        nivelActual,
        placesCount,
        routesCount,
        badgesCount,
        lastSyncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_usuarios';
  @override
  VerificationContext validateIntegrity(Insertable<LocalUsuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('auth_id')) {
      context.handle(_authIdMeta,
          authId.isAcceptableOrUnknown(data['auth_id']!, _authIdMeta));
    } else if (isInserting) {
      context.missing(_authIdMeta);
    }
    if (data.containsKey('nombre_completo')) {
      context.handle(
          _nombreCompletoMeta,
          nombreCompleto.isAcceptableOrUnknown(
              data['nombre_completo']!, _nombreCompletoMeta));
    } else if (isInserting) {
      context.missing(_nombreCompletoMeta);
    }
    if (data.containsKey('correo')) {
      context.handle(_correoMeta,
          correo.isAcceptableOrUnknown(data['correo']!, _correoMeta));
    } else if (isInserting) {
      context.missing(_correoMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('foto_perfil_url')) {
      context.handle(
          _fotoPerfilUrlMeta,
          fotoPerfilUrl.isAcceptableOrUnknown(
              data['foto_perfil_url']!, _fotoPerfilUrlMeta));
    }
    if (data.containsKey('xp_acumulada')) {
      context.handle(
          _xpAcumuladaMeta,
          xpAcumulada.isAcceptableOrUnknown(
              data['xp_acumulada']!, _xpAcumuladaMeta));
    }
    if (data.containsKey('nivel_actual')) {
      context.handle(
          _nivelActualMeta,
          nivelActual.isAcceptableOrUnknown(
              data['nivel_actual']!, _nivelActualMeta));
    }
    if (data.containsKey('places_count')) {
      context.handle(
          _placesCountMeta,
          placesCount.isAcceptableOrUnknown(
              data['places_count']!, _placesCountMeta));
    }
    if (data.containsKey('routes_count')) {
      context.handle(
          _routesCountMeta,
          routesCount.isAcceptableOrUnknown(
              data['routes_count']!, _routesCountMeta));
    }
    if (data.containsKey('badges_count')) {
      context.handle(
          _badgesCountMeta,
          badgesCount.isAcceptableOrUnknown(
              data['badges_count']!, _badgesCountMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUsuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUsuario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      authId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}auth_id'])!,
      nombreCompleto: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nombre_completo'])!,
      correo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correo'])!,
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol'])!,
      fotoPerfilUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_perfil_url']),
      xpAcumulada: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp_acumulada'])!,
      nivelActual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nivel_actual'])!,
      placesCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}places_count'])!,
      routesCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}routes_count'])!,
      badgesCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}badges_count'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
    );
  }

  @override
  $LocalUsuariosTable createAlias(String alias) {
    return $LocalUsuariosTable(attachedDatabase, alias);
  }
}

class LocalUsuario extends DataClass implements Insertable<LocalUsuario> {
  final String id;
  final String authId;
  final String nombreCompleto;
  final String correo;
  final String rol;
  final String? fotoPerfilUrl;
  final int xpAcumulada;
  final int nivelActual;
  final int placesCount;
  final int routesCount;
  final int badgesCount;
  final DateTime? lastSyncedAt;
  const LocalUsuario(
      {required this.id,
      required this.authId,
      required this.nombreCompleto,
      required this.correo,
      required this.rol,
      this.fotoPerfilUrl,
      required this.xpAcumulada,
      required this.nivelActual,
      required this.placesCount,
      required this.routesCount,
      required this.badgesCount,
      this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['auth_id'] = Variable<String>(authId);
    map['nombre_completo'] = Variable<String>(nombreCompleto);
    map['correo'] = Variable<String>(correo);
    map['rol'] = Variable<String>(rol);
    if (!nullToAbsent || fotoPerfilUrl != null) {
      map['foto_perfil_url'] = Variable<String>(fotoPerfilUrl);
    }
    map['xp_acumulada'] = Variable<int>(xpAcumulada);
    map['nivel_actual'] = Variable<int>(nivelActual);
    map['places_count'] = Variable<int>(placesCount);
    map['routes_count'] = Variable<int>(routesCount);
    map['badges_count'] = Variable<int>(badgesCount);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  LocalUsuariosCompanion toCompanion(bool nullToAbsent) {
    return LocalUsuariosCompanion(
      id: Value(id),
      authId: Value(authId),
      nombreCompleto: Value(nombreCompleto),
      correo: Value(correo),
      rol: Value(rol),
      fotoPerfilUrl: fotoPerfilUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoPerfilUrl),
      xpAcumulada: Value(xpAcumulada),
      nivelActual: Value(nivelActual),
      placesCount: Value(placesCount),
      routesCount: Value(routesCount),
      badgesCount: Value(badgesCount),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory LocalUsuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUsuario(
      id: serializer.fromJson<String>(json['id']),
      authId: serializer.fromJson<String>(json['authId']),
      nombreCompleto: serializer.fromJson<String>(json['nombreCompleto']),
      correo: serializer.fromJson<String>(json['correo']),
      rol: serializer.fromJson<String>(json['rol']),
      fotoPerfilUrl: serializer.fromJson<String?>(json['fotoPerfilUrl']),
      xpAcumulada: serializer.fromJson<int>(json['xpAcumulada']),
      nivelActual: serializer.fromJson<int>(json['nivelActual']),
      placesCount: serializer.fromJson<int>(json['placesCount']),
      routesCount: serializer.fromJson<int>(json['routesCount']),
      badgesCount: serializer.fromJson<int>(json['badgesCount']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'authId': serializer.toJson<String>(authId),
      'nombreCompleto': serializer.toJson<String>(nombreCompleto),
      'correo': serializer.toJson<String>(correo),
      'rol': serializer.toJson<String>(rol),
      'fotoPerfilUrl': serializer.toJson<String?>(fotoPerfilUrl),
      'xpAcumulada': serializer.toJson<int>(xpAcumulada),
      'nivelActual': serializer.toJson<int>(nivelActual),
      'placesCount': serializer.toJson<int>(placesCount),
      'routesCount': serializer.toJson<int>(routesCount),
      'badgesCount': serializer.toJson<int>(badgesCount),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  LocalUsuario copyWith(
          {String? id,
          String? authId,
          String? nombreCompleto,
          String? correo,
          String? rol,
          Value<String?> fotoPerfilUrl = const Value.absent(),
          int? xpAcumulada,
          int? nivelActual,
          int? placesCount,
          int? routesCount,
          int? badgesCount,
          Value<DateTime?> lastSyncedAt = const Value.absent()}) =>
      LocalUsuario(
        id: id ?? this.id,
        authId: authId ?? this.authId,
        nombreCompleto: nombreCompleto ?? this.nombreCompleto,
        correo: correo ?? this.correo,
        rol: rol ?? this.rol,
        fotoPerfilUrl:
            fotoPerfilUrl.present ? fotoPerfilUrl.value : this.fotoPerfilUrl,
        xpAcumulada: xpAcumulada ?? this.xpAcumulada,
        nivelActual: nivelActual ?? this.nivelActual,
        placesCount: placesCount ?? this.placesCount,
        routesCount: routesCount ?? this.routesCount,
        badgesCount: badgesCount ?? this.badgesCount,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
      );
  LocalUsuario copyWithCompanion(LocalUsuariosCompanion data) {
    return LocalUsuario(
      id: data.id.present ? data.id.value : this.id,
      authId: data.authId.present ? data.authId.value : this.authId,
      nombreCompleto: data.nombreCompleto.present
          ? data.nombreCompleto.value
          : this.nombreCompleto,
      correo: data.correo.present ? data.correo.value : this.correo,
      rol: data.rol.present ? data.rol.value : this.rol,
      fotoPerfilUrl: data.fotoPerfilUrl.present
          ? data.fotoPerfilUrl.value
          : this.fotoPerfilUrl,
      xpAcumulada:
          data.xpAcumulada.present ? data.xpAcumulada.value : this.xpAcumulada,
      nivelActual:
          data.nivelActual.present ? data.nivelActual.value : this.nivelActual,
      placesCount:
          data.placesCount.present ? data.placesCount.value : this.placesCount,
      routesCount:
          data.routesCount.present ? data.routesCount.value : this.routesCount,
      badgesCount:
          data.badgesCount.present ? data.badgesCount.value : this.badgesCount,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsuario(')
          ..write('id: $id, ')
          ..write('authId: $authId, ')
          ..write('nombreCompleto: $nombreCompleto, ')
          ..write('correo: $correo, ')
          ..write('rol: $rol, ')
          ..write('fotoPerfilUrl: $fotoPerfilUrl, ')
          ..write('xpAcumulada: $xpAcumulada, ')
          ..write('nivelActual: $nivelActual, ')
          ..write('placesCount: $placesCount, ')
          ..write('routesCount: $routesCount, ')
          ..write('badgesCount: $badgesCount, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      authId,
      nombreCompleto,
      correo,
      rol,
      fotoPerfilUrl,
      xpAcumulada,
      nivelActual,
      placesCount,
      routesCount,
      badgesCount,
      lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUsuario &&
          other.id == this.id &&
          other.authId == this.authId &&
          other.nombreCompleto == this.nombreCompleto &&
          other.correo == this.correo &&
          other.rol == this.rol &&
          other.fotoPerfilUrl == this.fotoPerfilUrl &&
          other.xpAcumulada == this.xpAcumulada &&
          other.nivelActual == this.nivelActual &&
          other.placesCount == this.placesCount &&
          other.routesCount == this.routesCount &&
          other.badgesCount == this.badgesCount &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class LocalUsuariosCompanion extends UpdateCompanion<LocalUsuario> {
  final Value<String> id;
  final Value<String> authId;
  final Value<String> nombreCompleto;
  final Value<String> correo;
  final Value<String> rol;
  final Value<String?> fotoPerfilUrl;
  final Value<int> xpAcumulada;
  final Value<int> nivelActual;
  final Value<int> placesCount;
  final Value<int> routesCount;
  final Value<int> badgesCount;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const LocalUsuariosCompanion({
    this.id = const Value.absent(),
    this.authId = const Value.absent(),
    this.nombreCompleto = const Value.absent(),
    this.correo = const Value.absent(),
    this.rol = const Value.absent(),
    this.fotoPerfilUrl = const Value.absent(),
    this.xpAcumulada = const Value.absent(),
    this.nivelActual = const Value.absent(),
    this.placesCount = const Value.absent(),
    this.routesCount = const Value.absent(),
    this.badgesCount = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsuariosCompanion.insert({
    required String id,
    required String authId,
    required String nombreCompleto,
    required String correo,
    required String rol,
    this.fotoPerfilUrl = const Value.absent(),
    this.xpAcumulada = const Value.absent(),
    this.nivelActual = const Value.absent(),
    this.placesCount = const Value.absent(),
    this.routesCount = const Value.absent(),
    this.badgesCount = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        authId = Value(authId),
        nombreCompleto = Value(nombreCompleto),
        correo = Value(correo),
        rol = Value(rol);
  static Insertable<LocalUsuario> custom({
    Expression<String>? id,
    Expression<String>? authId,
    Expression<String>? nombreCompleto,
    Expression<String>? correo,
    Expression<String>? rol,
    Expression<String>? fotoPerfilUrl,
    Expression<int>? xpAcumulada,
    Expression<int>? nivelActual,
    Expression<int>? placesCount,
    Expression<int>? routesCount,
    Expression<int>? badgesCount,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authId != null) 'auth_id': authId,
      if (nombreCompleto != null) 'nombre_completo': nombreCompleto,
      if (correo != null) 'correo': correo,
      if (rol != null) 'rol': rol,
      if (fotoPerfilUrl != null) 'foto_perfil_url': fotoPerfilUrl,
      if (xpAcumulada != null) 'xp_acumulada': xpAcumulada,
      if (nivelActual != null) 'nivel_actual': nivelActual,
      if (placesCount != null) 'places_count': placesCount,
      if (routesCount != null) 'routes_count': routesCount,
      if (badgesCount != null) 'badges_count': badgesCount,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsuariosCompanion copyWith(
      {Value<String>? id,
      Value<String>? authId,
      Value<String>? nombreCompleto,
      Value<String>? correo,
      Value<String>? rol,
      Value<String?>? fotoPerfilUrl,
      Value<int>? xpAcumulada,
      Value<int>? nivelActual,
      Value<int>? placesCount,
      Value<int>? routesCount,
      Value<int>? badgesCount,
      Value<DateTime?>? lastSyncedAt,
      Value<int>? rowid}) {
    return LocalUsuariosCompanion(
      id: id ?? this.id,
      authId: authId ?? this.authId,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      correo: correo ?? this.correo,
      rol: rol ?? this.rol,
      fotoPerfilUrl: fotoPerfilUrl ?? this.fotoPerfilUrl,
      xpAcumulada: xpAcumulada ?? this.xpAcumulada,
      nivelActual: nivelActual ?? this.nivelActual,
      placesCount: placesCount ?? this.placesCount,
      routesCount: routesCount ?? this.routesCount,
      badgesCount: badgesCount ?? this.badgesCount,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (authId.present) {
      map['auth_id'] = Variable<String>(authId.value);
    }
    if (nombreCompleto.present) {
      map['nombre_completo'] = Variable<String>(nombreCompleto.value);
    }
    if (correo.present) {
      map['correo'] = Variable<String>(correo.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (fotoPerfilUrl.present) {
      map['foto_perfil_url'] = Variable<String>(fotoPerfilUrl.value);
    }
    if (xpAcumulada.present) {
      map['xp_acumulada'] = Variable<int>(xpAcumulada.value);
    }
    if (nivelActual.present) {
      map['nivel_actual'] = Variable<int>(nivelActual.value);
    }
    if (placesCount.present) {
      map['places_count'] = Variable<int>(placesCount.value);
    }
    if (routesCount.present) {
      map['routes_count'] = Variable<int>(routesCount.value);
    }
    if (badgesCount.present) {
      map['badges_count'] = Variable<int>(badgesCount.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsuariosCompanion(')
          ..write('id: $id, ')
          ..write('authId: $authId, ')
          ..write('nombreCompleto: $nombreCompleto, ')
          ..write('correo: $correo, ')
          ..write('rol: $rol, ')
          ..write('fotoPerfilUrl: $fotoPerfilUrl, ')
          ..write('xpAcumulada: $xpAcumulada, ')
          ..write('nivelActual: $nivelActual, ')
          ..write('placesCount: $placesCount, ')
          ..write('routesCount: $routesCount, ')
          ..write('badgesCount: $badgesCount, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalUsuariosTable localUsuarios = $LocalUsuariosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localUsuarios];
}

typedef $$LocalUsuariosTableCreateCompanionBuilder = LocalUsuariosCompanion
    Function({
  required String id,
  required String authId,
  required String nombreCompleto,
  required String correo,
  required String rol,
  Value<String?> fotoPerfilUrl,
  Value<int> xpAcumulada,
  Value<int> nivelActual,
  Value<int> placesCount,
  Value<int> routesCount,
  Value<int> badgesCount,
  Value<DateTime?> lastSyncedAt,
  Value<int> rowid,
});
typedef $$LocalUsuariosTableUpdateCompanionBuilder = LocalUsuariosCompanion
    Function({
  Value<String> id,
  Value<String> authId,
  Value<String> nombreCompleto,
  Value<String> correo,
  Value<String> rol,
  Value<String?> fotoPerfilUrl,
  Value<int> xpAcumulada,
  Value<int> nivelActual,
  Value<int> placesCount,
  Value<int> routesCount,
  Value<int> badgesCount,
  Value<DateTime?> lastSyncedAt,
  Value<int> rowid,
});

class $$LocalUsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsuariosTable> {
  $$LocalUsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authId => $composableBuilder(
      column: $table.authId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreCompleto => $composableBuilder(
      column: $table.nombreCompleto,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correo => $composableBuilder(
      column: $table.correo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotoPerfilUrl => $composableBuilder(
      column: $table.fotoPerfilUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xpAcumulada => $composableBuilder(
      column: $table.xpAcumulada, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nivelActual => $composableBuilder(
      column: $table.nivelActual, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get placesCount => $composableBuilder(
      column: $table.placesCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get routesCount => $composableBuilder(
      column: $table.routesCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get badgesCount => $composableBuilder(
      column: $table.badgesCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalUsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsuariosTable> {
  $$LocalUsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authId => $composableBuilder(
      column: $table.authId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreCompleto => $composableBuilder(
      column: $table.nombreCompleto,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correo => $composableBuilder(
      column: $table.correo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoPerfilUrl => $composableBuilder(
      column: $table.fotoPerfilUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xpAcumulada => $composableBuilder(
      column: $table.xpAcumulada, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nivelActual => $composableBuilder(
      column: $table.nivelActual, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get placesCount => $composableBuilder(
      column: $table.placesCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get routesCount => $composableBuilder(
      column: $table.routesCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get badgesCount => $composableBuilder(
      column: $table.badgesCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$LocalUsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsuariosTable> {
  $$LocalUsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get authId =>
      $composableBuilder(column: $table.authId, builder: (column) => column);

  GeneratedColumn<String> get nombreCompleto => $composableBuilder(
      column: $table.nombreCompleto, builder: (column) => column);

  GeneratedColumn<String> get correo =>
      $composableBuilder(column: $table.correo, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<String> get fotoPerfilUrl => $composableBuilder(
      column: $table.fotoPerfilUrl, builder: (column) => column);

  GeneratedColumn<int> get xpAcumulada => $composableBuilder(
      column: $table.xpAcumulada, builder: (column) => column);

  GeneratedColumn<int> get nivelActual => $composableBuilder(
      column: $table.nivelActual, builder: (column) => column);

  GeneratedColumn<int> get placesCount => $composableBuilder(
      column: $table.placesCount, builder: (column) => column);

  GeneratedColumn<int> get routesCount => $composableBuilder(
      column: $table.routesCount, builder: (column) => column);

  GeneratedColumn<int> get badgesCount => $composableBuilder(
      column: $table.badgesCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);
}

class $$LocalUsuariosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUsuariosTable,
    LocalUsuario,
    $$LocalUsuariosTableFilterComposer,
    $$LocalUsuariosTableOrderingComposer,
    $$LocalUsuariosTableAnnotationComposer,
    $$LocalUsuariosTableCreateCompanionBuilder,
    $$LocalUsuariosTableUpdateCompanionBuilder,
    (
      LocalUsuario,
      BaseReferences<_$AppDatabase, $LocalUsuariosTable, LocalUsuario>
    ),
    LocalUsuario,
    PrefetchHooks Function()> {
  $$LocalUsuariosTableTableManager(_$AppDatabase db, $LocalUsuariosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> authId = const Value.absent(),
            Value<String> nombreCompleto = const Value.absent(),
            Value<String> correo = const Value.absent(),
            Value<String> rol = const Value.absent(),
            Value<String?> fotoPerfilUrl = const Value.absent(),
            Value<int> xpAcumulada = const Value.absent(),
            Value<int> nivelActual = const Value.absent(),
            Value<int> placesCount = const Value.absent(),
            Value<int> routesCount = const Value.absent(),
            Value<int> badgesCount = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUsuariosCompanion(
            id: id,
            authId: authId,
            nombreCompleto: nombreCompleto,
            correo: correo,
            rol: rol,
            fotoPerfilUrl: fotoPerfilUrl,
            xpAcumulada: xpAcumulada,
            nivelActual: nivelActual,
            placesCount: placesCount,
            routesCount: routesCount,
            badgesCount: badgesCount,
            lastSyncedAt: lastSyncedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String authId,
            required String nombreCompleto,
            required String correo,
            required String rol,
            Value<String?> fotoPerfilUrl = const Value.absent(),
            Value<int> xpAcumulada = const Value.absent(),
            Value<int> nivelActual = const Value.absent(),
            Value<int> placesCount = const Value.absent(),
            Value<int> routesCount = const Value.absent(),
            Value<int> badgesCount = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUsuariosCompanion.insert(
            id: id,
            authId: authId,
            nombreCompleto: nombreCompleto,
            correo: correo,
            rol: rol,
            fotoPerfilUrl: fotoPerfilUrl,
            xpAcumulada: xpAcumulada,
            nivelActual: nivelActual,
            placesCount: placesCount,
            routesCount: routesCount,
            badgesCount: badgesCount,
            lastSyncedAt: lastSyncedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalUsuariosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalUsuariosTable,
    LocalUsuario,
    $$LocalUsuariosTableFilterComposer,
    $$LocalUsuariosTableOrderingComposer,
    $$LocalUsuariosTableAnnotationComposer,
    $$LocalUsuariosTableCreateCompanionBuilder,
    $$LocalUsuariosTableUpdateCompanionBuilder,
    (
      LocalUsuario,
      BaseReferences<_$AppDatabase, $LocalUsuariosTable, LocalUsuario>
    ),
    LocalUsuario,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalUsuariosTableTableManager get localUsuarios =>
      $$LocalUsuariosTableTableManager(_db, _db.localUsuarios);
}
