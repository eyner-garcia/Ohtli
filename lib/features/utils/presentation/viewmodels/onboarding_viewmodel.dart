import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/utils/domain/repositories/utils_repository.dart';
import 'package:Ohtli/features/utils/presentation/viewmodels/utils_providers.dart';

class OnboardingViewModel extends StateNotifier<AsyncValue<void>> {
  final UtilsRepository _repository;

  OnboardingViewModel(this._repository) : super(const AsyncValue.data(null));
}

final onboardingViewModelProvider =
    StateNotifierProvider<OnboardingViewModel, AsyncValue<void>>((ref) {
  return OnboardingViewModel(ref.watch(utilsRepositoryProvider));
});
