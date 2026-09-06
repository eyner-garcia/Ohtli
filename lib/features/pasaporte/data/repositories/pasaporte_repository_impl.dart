import '../../domain/entities/pasaporte_entity.dart';
import '../../domain/repositories/pasaporte_repository.dart';
import '../datasources/pasaporte_remote_datasource.dart';

class PasaporteRepositoryImpl implements PasaporteRepository {
  final PasaporteRemoteDataSource _remoteDataSource;

  PasaporteRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PasaporteEntity>> getPasaporteData() {
    return _remoteDataSource.fetchPasaporteData();
  }
}
