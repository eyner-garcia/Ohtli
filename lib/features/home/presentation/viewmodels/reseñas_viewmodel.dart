import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/home/domain/entities/review_entity.dart';
import 'package:Ohtli/features/home/domain/repositories/home_repository.dart';
import 'package:Ohtli/features/home/presentation/viewmodels/home_providers.dart';

class ResenasViewModel extends StateNotifier<AsyncValue<List<ReviewEntity>>> {
  final HomeRepository _repository;

  ResenasViewModel(this._repository) : super(const AsyncValue.loading());

  Future<void> loadReviews(String destinationId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getDestinationReviews(destinationId));
  }
}

final resenasViewModelProvider =
    StateNotifierProvider<ResenasViewModel, AsyncValue<List<ReviewEntity>>>((ref) {
  return ResenasViewModel(ref.watch(homeRepositoryProvider));
});
