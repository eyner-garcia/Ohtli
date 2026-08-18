import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

class LocalUsuarios extends Table {
  TextColumn get id => text()();
  TextColumn get authId => text()();
  TextColumn get nombreCompleto => text()();
  TextColumn get correo => text()();
  TextColumn get rol => text()();
  IntColumn get xpAcumulada => integer().withDefault(const Constant(0))();
  IntColumn get nivelActual => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKeys => {id};
}

@DriftDatabase(tables: [LocalUsuarios])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});