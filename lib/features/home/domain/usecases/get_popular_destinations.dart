import '../entities/destination_entity.dart';
import '../repositories/home_repository.dart';

class GetPopularDestinations {
  final HomeRepository _repository;

  GetPopularDestinations(this._repository);

  Future<List<DestinationEntity>> call() async {
    return await _repository.getPopularDestinations();
  }
}
