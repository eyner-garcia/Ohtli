import '../entities/map_point_entity.dart';
import '../repositories/map_repository.dart';

class GetMapPoints {
  final MapRepository _repository;

  GetMapPoints(this._repository);

  Future<List<MapPointEntity>> call() async {
    return await _repository.getMapPoints();
  }
}
