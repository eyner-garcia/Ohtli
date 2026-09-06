import 'package:Ohtli/features/pasaporte/presentation/viewmodels/providers/passport_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/pasaporte/domain/repositories/passport_repository.dart';

class IngresarPinViewModel extends StateNotifier<AsyncValue<void>> {
  final PassportRepository _repository;

  IngresarPinViewModel(this._repository) : super(const AsyncValue.data(null));
}

final ingresarPinViewModelProvider =
    StateNotifierProvider<IngresarPinViewModel, AsyncValue<void>>((ref) {
  return IngresarPinViewModel(ref.watch(passportRepositoryProvider));
});
