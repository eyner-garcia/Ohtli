import '../entities/review_entity.dart';
import '../repositories/home_repository.dart';

class GetDestinationReviews {
  final HomeRepository _repository;

  GetDestinationReviews(this._repository);

  Future<List<ReviewEntity>> call(String destinationId) async {
    return await _repository.getDestinationReviews(destinationId);
  }
}
