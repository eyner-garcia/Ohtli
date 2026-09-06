import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../models/destination_model.dart';
import '../models/review_model.dart';

class HomeRemoteDataSource {
  final SupabaseClient _client;

  HomeRemoteDataSource(this._client);

  Future<Position> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Position(
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
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Position(
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
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Position(
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
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
    } catch (_) {
      return Position(
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
    }
  }

  Future<List<DestinationModel>> getPopularDestinations() async {
    try {
      final userPos = await _getUserLocation();
      final response = await _client
          .from('puntos_interes')
          .select()
          .eq('es_activo', true);

      final List<dynamic> data = response as List;
      final destinations = data.map((e) {
        final model = DestinationModel.fromJson(e);
        if (model.latitude != null && model.longitude != null) {
          final distanceInMeters = Geolocator.distanceBetween(
            userPos.latitude,
            userPos.longitude,
            model.latitude!,
            model.longitude!,
          );
          final km = distanceInMeters / 1000.0;
          return DestinationModel(
            id: model.id,
            title: model.title,
            location: model.location,
            rating: model.rating,
            reviewsCount: model.reviewsCount,
            description: model.description,
            distance: '${km.toStringAsFixed(1)} km',
            gallery: model.gallery,
            imageUrl: model.imageUrl,
            latitude: model.latitude,
            longitude: model.longitude,
            categoryId: model.categoryId,
          );
        }
        return model;
      }).toList();

      destinations.sort((a, b) => b.rating.compareTo(a.rating));
      return destinations;
    } catch (_) {
      return [];
    }
  }

  Future<List<DestinationModel>> getNearbyPlaces() async {
    try {
      final userPos = await _getUserLocation();
      final response = await _client
          .from('puntos_interes')
          .select()
          .eq('es_activo', true);

      final List<dynamic> data = response as List;
      final destinations = data.map((e) {
        final model = DestinationModel.fromJson(e);
        double km = 0.0;
        if (model.latitude != null && model.longitude != null) {
          final distanceInMeters = Geolocator.distanceBetween(
            userPos.latitude,
            userPos.longitude,
            model.latitude!,
            model.longitude!,
          );
          km = distanceInMeters / 1000.0;
        }
        return DestinationModel(
          id: model.id,
          title: model.title,
          location: model.location,
          rating: model.rating,
          reviewsCount: model.reviewsCount,
          description: model.description,
          distance: 'A ${km.toStringAsFixed(1)} km de distancia',
          gallery: model.gallery,
          imageUrl: model.imageUrl,
          latitude: model.latitude,
          longitude: model.longitude,
          categoryId: model.categoryId,
        );
      }).toList();

      destinations.sort((a, b) {
        final distA = double.tryParse(a.distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
        final distB = double.tryParse(b.distance.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
        return distA.compareTo(distB);
      });

      return destinations;
    } catch (_) {
      return [];
    }
  }

  Future<DestinationModel> getDestinationDetails(String id) async {
    try {
      final response = await _client
          .from('puntos_interes')
          .select()
          .eq('id', id)
          .single();
      return DestinationModel.fromJson(response);
    } catch (_) {
      throw Exception('Destino no encontrado');
    }
  }

  Future<List<ReviewModel>> getDestinationReviews(String destinationId) async {
    try {
      final response = await _client
          .from('reseñas')
          .select()
          .eq('destination_id', destinationId);
      return (response as List).map((e) => ReviewModel.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }
}
