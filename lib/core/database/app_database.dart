import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';
class LocalUsuarios extends Table {
  TextColumn get id => text()();
  TextColumn get authId => text()();
  TextColumn get nombreCompleto => text()();
  TextColumn get correo => text()();
  TextColumn get rol => text()();
  TextColumn get fotoPerfilUrl => text().nullable()();
  IntColumn get xpAcumulada =>
      integer().withDefault(const Constant(0))();
  IntColumn get nivelActual =>
      integer().withDefault(const Constant(1))();

  IntColumn get placesCount =>
      integer().withDefault(const Constant(0))();

  IntColumn get routesCount =>
      integer().withDefault(const Constant(0))();

  IntColumn get badgesCount =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get lastSyncedAt =>
      dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [LocalUsuarios])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      for (final table in allTables) {
        await m.deleteTable(table.actualTableName);
      }
      await m.createAll();
    },
  );
}

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sirius_local.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});