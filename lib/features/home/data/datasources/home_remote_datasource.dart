import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/destination_model.dart';
import '../models/review_model.dart';

class HomeRemoteDataSource {
  final SupabaseClient _client;

  HomeRemoteDataSource(this._client);

  Future<List<DestinationModel>> getPopularDestinations() async {
    // Implementación real con Supabase en el futuro
    return [];
  }

  Future<List<DestinationModel>> getNearbyPlaces() async {
    return [];
  }

  Future<DestinationModel> getDestinationDetails(String id) async {
    // Mock o implementación real
    throw UnimplementedError();
  }

  Future<List<ReviewModel>> getDestinationReviews(String destinationId) async {
    return [];
  }
}
