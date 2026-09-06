import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latlong2/latlong.dart';
import '../models/map_point_model.dart';
import '../../domain/entities/route_entity.dart';

class MapaRemoteDataSource {
  final SupabaseClient _client;

  MapaRemoteDataSource(this._client);

  Future<List<MapPointModel>> getMapPoints() async {
    try {
      final response = await _client
          .from('puntos_interes')
          .select()
          .eq('es_activo', true);

      final List<dynamic> data = response as List;
      return data.map((e) => MapPointModel.fromJson(e)).toList();
    } catch (_) {
      try {
        final response = await _client.from('places').select();
        final List<dynamic> data = response as List;
        return data.map((e) => MapPointModel.fromJson(e)).toList();
      } catch (_) {
        return [];
      }
    }
  }

  Future<List<RouteEntity>> getSuggestedRoutes() async {
    try {
      final response = await _client.from('rutas_sugeridas').select();
      final List<dynamic> data = response as List;
      if (data.isNotEmpty) {
        return data.map((e) => RouteEntity(
          id: e['id']?.toString() ?? '1',
          title: e['titulo'] ?? e['title'] ?? 'Ruta',
          origin: e['origen'] ?? 'Mi ubicación',
          destination: e['destino'] ?? 'Destino',
          duration: e['duracion'] ?? '1h 45m',
          distance: e['distancia'] ?? '3.2 km',
          difficulty: e['dificultad'] ?? 'Media',
          steps: [],
          polylinePoints: const [
            LatLng(12.9261, -85.9181),
            LatLng(12.9350, -85.9250),
            LatLng(12.9450, -85.9300),
          ],
        )).toList();
      }
    } catch (_) {}
    return [
      RouteEntity(
        id: '1',
        title: 'Ruta del Sol',
        origin: 'Mi ubicación actual',
        destination: 'Finca El Castillo',
        duration: '1h 45m',
        distance: '3.2 km',
        difficulty: 'Media',
        steps: [
          RouteStepEntity(stepNumber: 1, instruction: 'Sal hacia el norte por la vía principal', subInstruction: 'Camina 200m hasta el cruce'),
          RouteStepEntity(stepNumber: 2, instruction: 'Gira a la derecha hacia el sendero cafetalero', subInstruction: 'Camina 500m disfrutando de la vista'),
          RouteStepEntity(stepNumber: 3, instruction: 'Llega a Finca El Castillo', subInstruction: 'Entrada principal del tour de café'),
        ],
        polylinePoints: const [
          LatLng(12.9261, -85.9181),
          LatLng(12.9320, -85.9220),
          LatLng(12.9400, -85.9280),
        ],
      ),
      RouteEntity(
        id: '2',
        title: 'Sendero Sagrado',
        origin: 'Centro de Matagalpa',
        destination: 'Cascada El Salto Verde',
        duration: '2h 15m',
        distance: '4.5 km',
        difficulty: 'Alta',
        steps: [
          RouteStepEntity(stepNumber: 1, instruction: 'Inicia el recorrido en el punto de partida', subInstruction: 'Sigue el sendero señalizado por la montaña'),
          RouteStepEntity(stepNumber: 2, instruction: 'Cruza el puente de madera', subInstruction: 'Continúa por la falda de la reserva'),
          RouteStepEntity(stepNumber: 3, instruction: 'Llegada a la Cascada El Salto Verde', subInstruction: 'Disfruta de la naturaleza'),
        ],
        polylinePoints: const [
          LatLng(12.9261, -85.9181),
          LatLng(12.9300, -85.9100),
          LatLng(12.9500, -85.9300),
        ],
      ),
    ];
  }

  Future<List<RouteEntity>> getRecentRoutes() async {
    return [
      RouteEntity(
        id: 'r1',
        title: 'Mi Ubicación → Finca El Castillo',
        origin: 'Mi ubicación actual',
        destination: 'Finca El Castillo',
        duration: '45m',
        distance: '2.1 km',
        difficulty: 'Fácil',
        steps: [
          RouteStepEntity(stepNumber: 1, instruction: 'Dirígete al norte', subInstruction: 'Camina 400m'),
          RouteStepEntity(stepNumber: 2, instruction: 'Llegada al destino', subInstruction: 'Finca El Castillo'),
        ],
        polylinePoints: const [
          LatLng(12.9261, -85.9181),
          LatLng(12.9310, -85.9200),
        ],
      ),
      RouteEntity(
        id: 'r2',
        title: 'Centro → Cascada El Salto Verde',
        origin: 'Centro',
        destination: 'Cascada El Salto Verde',
        duration: '1h 30m',
        distance: '5.0 km',
        difficulty: 'Media',
        steps: [
          RouteStepEntity(stepNumber: 1, instruction: 'Toma la vía este', subInstruction: 'Sigue la señalización'),
        ],
        polylinePoints: const [
          LatLng(12.9261, -85.9181),
          LatLng(12.9450, -85.9250),
        ],
      ),
    ];
  }
}
