import '../entities/map_point_entity.dart';
import '../entities/route_entity.dart';

abstract class MapRepository {
  Future<List<MapPointEntity>> getMapPoints();
  Future<List<RouteEntity>> getSuggestedRoutes();
  Future<List<RouteEntity>> getRecentRoutes();
}
