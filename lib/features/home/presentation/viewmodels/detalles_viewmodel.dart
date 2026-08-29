import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/home/domain/entities/destination_entity.dart';
import 'package:Ohtli/features/home/domain/repositories/home_repository.dart';
import 'package:Ohtli/features/home/presentation/viewmodels/home_providers.dart';

class DetallesViewModel extends StateNotifier<AsyncValue<DestinationEntity?>> {
  final HomeRepository _repository;

  DetallesViewModel(this._repository) : super(const AsyncValue.data(null));

  Future<void> loadDestinationDetails(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getDestinationDetails(id));
  }
}

final detallesViewModelProvider =
    StateNotifierProvider<DetallesViewModel, AsyncValue<DestinationEntity?>>((ref) {
  return DetallesViewModel(ref.watch(homeRepositoryProvider));
});
