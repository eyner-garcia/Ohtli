import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/mapa/domain/repositories/map_repository.dart';
import 'package:Ohtli/features/mapa/presentation/viewmodels/mapa_providers.dart';

class RutaViewModel extends StateNotifier<AsyncValue<void>> {
  final MapRepository _repository;

  RutaViewModel(this._repository) : super(const AsyncValue.data(null));
}

final rutaViewModelProvider =
    StateNotifierProvider<RutaViewModel, AsyncValue<void>>((ref) {
  return RutaViewModel(ref.watch(mapRepositoryProvider));
});
