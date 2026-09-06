import '../../domain/entities/map_point_entity.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/mapa_remote_datasource.dart';

class MapRepositoryImpl implements MapRepository {
  final MapaRemoteDataSource _remoteDataSource;

  MapRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<MapPointEntity>> getMapPoints() async {
    return await _remoteDataSource.getMapPoints();
  }

  @override
  Future<List<RouteEntity>> getSuggestedRoutes() async {
    return await _remoteDataSource.getSuggestedRoutes();
  }

  @override
  Future<List<RouteEntity>> getRecentRoutes() async {
    return await _remoteDataSource.getRecentRoutes();
  }
}
