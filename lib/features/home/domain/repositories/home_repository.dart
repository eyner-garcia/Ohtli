import '../entities/destination_entity.dart';
import '../entities/review_entity.dart';

abstract class HomeRepository {
  Future<List<DestinationEntity>> getPopularDestinations();
  Future<List<DestinationEntity>> getNearbyPlaces();
  Future<DestinationEntity> getDestinationDetails(String id);
  Future<List<ReviewEntity>> getDestinationReviews(String destinationId);
}
