import 'package:Ohtli/features/pasaporte/presentation/viewmodels/providers/passport_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/pasaporte/domain/repositories/passport_repository.dart';

class InsigniasViewModel extends StateNotifier<AsyncValue<void>> {
  final PassportRepository _repository;

  InsigniasViewModel(this._repository) : super(const AsyncValue.data(null));
}

final insigniasViewModelProvider =
    StateNotifierProvider<InsigniasViewModel, AsyncValue<void>>((ref) {
  return InsigniasViewModel(ref.watch(passportRepositoryProvider));
});
