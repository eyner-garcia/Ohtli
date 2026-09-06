import '../../domain/entities/destination_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<DestinationEntity>> getPopularDestinations() {
    return _remoteDataSource.getPopularDestinations();
  }

  @override
  Future<List<DestinationEntity>> getNearbyPlaces() {
    return _remoteDataSource.getNearbyPlaces();
  }

  @override
  Future<DestinationEntity> getDestinationDetails(String id) {
    return _remoteDataSource.getDestinationDetails(id);
  }

  @override
  Future<List<ReviewEntity>> getDestinationReviews(String destinationId) {
    return _remoteDataSource.getDestinationReviews(destinationId);
  }
}
