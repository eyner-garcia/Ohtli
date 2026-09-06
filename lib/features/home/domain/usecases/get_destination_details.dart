import '../entities/destination_entity.dart';
import '../repositories/home_repository.dart';

class GetDestinationDetails {
  final HomeRepository _repository;

  GetDestinationDetails(this._repository);

  Future<DestinationEntity> call(String id) async {
    return await _repository.getDestinationDetails(id);
  }
}
