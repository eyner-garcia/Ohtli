import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/map_point_entity.dart';
import '../../domain/entities/route_entity.dart';
import 'mapa_providers.dart';

part 'mapa_viewmodel.g.dart';

class MapaState {
  final List<MapPointEntity> points;
  final List<RouteEntity> suggestedRoutes;
  final List<RouteEntity> recentRoutes;

  MapaState({
    required this.points,
    required this.suggestedRoutes,
    required this.recentRoutes,
  });
}

@riverpod
class MapaViewModel extends _$MapaViewModel {
  @override
  FutureOr<MapaState> build() async {
    final mapRepo = ref.watch(mapRepositoryProvider);

    List<MapPointEntity> points = [];
    List<RouteEntity> suggested = [];
    List<RouteEntity> recent = [];

    try {
      points = await mapRepo.getMapPoints();
    } catch (_) {
      points = [];
    }

    try {
      suggested = await mapRepo.getSuggestedRoutes();
    } catch (_) {
      suggested = [];
    }

    try {
      recent = await mapRepo.getRecentRoutes();
    } catch (_) {
      recent = [];
    }

    if (points.isEmpty) {
      points = [
        MapPointEntity(
          id: '1',
          title: 'Machu Picchu',
          description: 'Santuario histórico inca.',
          latitude: -13.163141,
          longitude: -72.545016,
          category: 'Cultura',
        ),
        MapPointEntity(
          id: '2',
          title: 'Finca El Castillo',
          description: 'Tour de café en Matagalpa.',
          latitude: 12.9261,
          longitude: -85.9181,
          category: 'Naturaleza',
        ),
      ];
    }

    return MapaState(
      points: points,
      suggestedRoutes: suggested,
      recentRoutes: recent,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      ref.invalidateSelf();
      return await future;
    });
  }
}
