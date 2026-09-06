import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/mapa/domain/repositories/map_repository.dart';
import 'package:Ohtli/features/mapa/presentation/viewmodels/mapa_providers.dart';

class DetallesMapaViewModel extends StateNotifier<AsyncValue<void>> {
  final MapRepository _repository;

  DetallesMapaViewModel(this._repository) : super(const AsyncValue.data(null));
}

final detallesMapaViewModelProvider =
    StateNotifierProvider<DetallesMapaViewModel, AsyncValue<void>>((ref) {
  return DetallesMapaViewModel(ref.watch(mapRepositoryProvider));
});
