import 'package:Ohtli/features/mapa/domain/entities/mapa_entity.dart';

abstract class MapaRepository {
  Future<List<MapaEntity>> getMapaData();
}
