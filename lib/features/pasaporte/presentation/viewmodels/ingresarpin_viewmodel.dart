import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/pasaporte/domain/repositories/pasaporte_repository.dart';
import 'package:Ohtli/features/pasaporte/presentation/viewmodels/pasaporte_providers.dart';

class IngresarPinViewModel extends StateNotifier<AsyncValue<void>> {
  final PasaporteRepository _repository;

  IngresarPinViewModel(this._repository) : super(const AsyncValue.data(null));
}

final ingresarPinViewModelProvider =
    StateNotifierProvider<IngresarPinViewModel, AsyncValue<void>>((ref) {
  return IngresarPinViewModel(ref.watch(pasaporteRepositoryProvider));
});
