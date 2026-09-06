import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/destination_model.dart';
import '../models/review_model.dart';

class HomeRemoteDataSource {
  final SupabaseClient _client;

  // Ubicación por defecto
  static final Position _defaultPosition = Position(
    latitude: 12.9261,
    longitude: -85.9181,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  HomeRemoteDataSource(this._client);

  Future<Position> _getUserLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return _defaultPosition;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return _defaultPosition;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
    } catch (_) {
      return _defaultPosition;
    }
  }

  // Método auxiliar para evitar duplicación de cálculo de distancia
  DestinationModel _applyDistanceToModel(
      DestinationModel model,
      Position userPos, {
        required String formatPattern,
      }) {
    if (model.latitude == null || model.longitude == null) {
      return model;
    }

    final distanceInMeters = Geolocator.distanceBetween(
      userPos.latitude,
      userPos.longitude,
      model.latitude!,
      model.longitude!,
    );
    final km = distanceInMeters / 1000.0;
    final formattedKm = km.toStringAsFixed(1);

    final distanceText = formatPattern.replaceAll('{km}', formattedKm);

    return DestinationModel(
      id: model.id,
      title: model.title,
      location: model.location,
      rating: model.rating,
      reviewsCount: model.reviewsCount,
      description: model.description,
      distance: distanceText,
      gallery: model.gallery,
      imageUrl: model.imageUrl,
      latitude: model.latitude,
      longitude: model.longitude,
      categoryId: model.categoryId,
    );
  }

  Future<List<DestinationModel>> getPopularDestinations() async {
    try {
      final userPos = await _getUserLocation();
      final List<dynamic> response = await _client
          .from('puntos_interes')
          .select()
          .eq('es_activo', true);

      final destinations = response.map((e) {
        final model = DestinationModel.fromJson(e);
        return _applyDistanceToModel(
          model,
          userPos,
          formatPattern: '{km} km',
        );
      }).toList();

      destinations.sort((a, b) => b.rating.compareTo(a.rating));
      return destinations;
    } catch (e) {
      return [];
    }
  }

  Future<List<DestinationModel>> getNearbyPlaces() async {
    try {
      final userPos = await _getUserLocation();
      final List<dynamic> response = await _client
          .from('puntos_interes')
          .select()
          .eq('es_activo', true);

      final List<({DestinationModel model, double distanceKm})> mapped = [];

      for (final e in response) {
        final model = DestinationModel.fromJson(e);
        double distanceKm = double.infinity;

        if (model.latitude != null && model.longitude != null) {
          final meters = Geolocator.distanceBetween(
            userPos.latitude,
            userPos.longitude,
            model.latitude!,
            model.longitude!,
          );
          distanceKm = meters / 1000.0;
        }

        final updatedModel = DestinationModel(
          id: model.id,
          title: model.title,
          location: model.location,
          rating: model.rating,
          reviewsCount: model.reviewsCount,
          description: model.description,
          distance: distanceKm.isInfinite
              ? 'Distancia desconocida'
              : 'A ${distanceKm.toStringAsFixed(1)} km de distancia',
          gallery: model.gallery,
          imageUrl: model.imageUrl,
          latitude: model.latitude,
          longitude: model.longitude,
          categoryId: model.categoryId,
        );

        mapped.add((model: updatedModel, distanceKm: distanceKm));
      }

      // Ordenado directo sobre valor numérico (sin parsear el String generado)
      mapped.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      return mapped.map((e) => e.model).toList();
    } catch (e) {
      return [];
    }
  }

  Future<DestinationModel> getDestinationDetails(String id) async {
    final response = await _client
        .from('puntos_interes')
        .select()
        .eq('id', id)
        .single();

    return DestinationModel.fromJson(response);
  }

  Future<List<ReviewModel>> getDestinationReviews(String destinationId) async {
    try {
      final List<dynamic> response = await _client
          .from('reseñas')
          .select()
          .eq('destination_id', destinationId);

      return response.map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}