import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Ohtli/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../data/datasources/mapa_remote_datasource.dart';
import '../../data/repositories/map_repository_impl.dart';
import '../../domain/repositories/map_repository.dart';
import '../../domain/usecases/get_map_points.dart';

part 'mapa_providers.g.dart';

@Riverpod(keepAlive: true)
MapaRemoteDataSource mapaRemoteDataSource(MapaRemoteDataSourceRef ref) {
  return MapaRemoteDataSource(ref.watch(supabaseClientProvider));
}

@Riverpod(keepAlive: true)
MapRepository mapRepository(MapRepositoryRef ref) {
  return MapRepositoryImpl(ref.watch(mapaRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetMapPoints getMapPoints(GetMapPointsRef ref) {
  return GetMapPoints(ref.watch(mapRepositoryProvider));
}
