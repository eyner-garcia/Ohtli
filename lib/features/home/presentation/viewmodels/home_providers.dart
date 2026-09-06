import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_destination_details.dart';
import '../../domain/usecases/get_destination_reviews.dart';
import '../../domain/usecases/get_nearby_places.dart';
import '../../domain/usecases/get_popular_destinations.dart';

part 'home_providers.g.dart';

@Riverpod(keepAlive: true)
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  return HomeRemoteDataSource(ref.watch(supabaseClientProvider));
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl(ref.watch(homeRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetPopularDestinations getPopularDestinations(GetPopularDestinationsRef ref) {
  return GetPopularDestinations(ref.watch(homeRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetNearbyPlaces getNearbyPlaces(GetNearbyPlacesRef ref) {
  return GetNearbyPlaces(ref.watch(homeRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetDestinationDetails getDestinationDetails(GetDestinationDetailsRef ref) {
  return GetDestinationDetails(ref.watch(homeRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetDestinationReviews getDestinationReviews(GetDestinationReviewsRef ref) {
  return GetDestinationReviews(ref.watch(homeRepositoryProvider));
}
