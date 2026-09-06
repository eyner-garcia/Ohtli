import 'package:Ohtli/features/pasaporte/domain/entities/pasaporte_entity.dart';

abstract class PasaporteRepository {
  Future<List<PasaporteEntity>> getPasaporteData();
}
