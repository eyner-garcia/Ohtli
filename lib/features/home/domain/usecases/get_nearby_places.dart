import '../entities/destination_entity.dart';
import '../repositories/home_repository.dart';

class GetNearbyPlaces {
  final HomeRepository _repository;

  GetNearbyPlaces(this._repository);

  Future<List<DestinationEntity>> call() async {
    return await _repository.getNearbyPlaces();
  }
}
