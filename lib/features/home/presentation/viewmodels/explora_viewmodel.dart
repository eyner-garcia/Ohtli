import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/home/domain/entities/destination_entity.dart';
import 'package:Ohtli/features/home/domain/repositories/home_repository.dart';
import 'package:Ohtli/features/home/presentation/viewmodels/home_providers.dart';

class ExploraState {
  final AsyncValue<List<DestinationEntity>> popularDestinations;
  final AsyncValue<List<DestinationEntity>> nearbyPlaces;

  ExploraState({
    required this.popularDestinations,
    required this.nearbyPlaces,
  });

  ExploraState copyWith({
    AsyncValue<List<DestinationEntity>>? popularDestinations,
    AsyncValue<List<DestinationEntity>>? nearbyPlaces,
  }) {
    return ExploraState(
      popularDestinations: popularDestinations ?? this.popularDestinations,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
    );
  }
}

class ExploraViewModel extends StateNotifier<ExploraState> {
  final HomeRepository _repository;

  ExploraViewModel(this._repository)
      : super(ExploraState(
          popularDestinations: const AsyncValue.loading(),
          nearbyPlaces: const AsyncValue.loading(),
        )) {
    loadAll();
  }

  Future<void> loadAll() async {
    await Future.wait([
      loadPopular(),
      loadNearby(),
    ]);
  }

  Future<void> loadPopular() async {
    state = state.copyWith(popularDestinations: const AsyncValue.loading());
    final result = await AsyncValue.guard(() => _repository.getPopularDestinations());
    state = state.copyWith(popularDestinations: result);
  }

  Future<void> loadNearby() async {
    state = state.copyWith(nearbyPlaces: const AsyncValue.loading());
    final result = await AsyncValue.guard(() => _repository.getNearbyPlaces());
    state = state.copyWith(nearbyPlaces: result);
  }
}

final exploraViewModelProvider =
    StateNotifierProvider<ExploraViewModel, ExploraState>((ref) {
  return ExploraViewModel(ref.watch(homeRepositoryProvider));
});
