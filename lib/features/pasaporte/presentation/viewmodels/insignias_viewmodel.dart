import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/pasaporte/domain/repositories/pasaporte_repository.dart';
import 'package:Ohtli/features/pasaporte/presentation/viewmodels/pasaporte_providers.dart';

class InsigniasViewModel extends StateNotifier<AsyncValue<void>> {
  final PasaporteRepository _repository;

  InsigniasViewModel(this._repository) : super(const AsyncValue.data(null));
}

final insigniasViewModelProvider =
    StateNotifierProvider<InsigniasViewModel, AsyncValue<void>>((ref) {
  return InsigniasViewModel(ref.watch(pasaporteRepositoryProvider));
});
