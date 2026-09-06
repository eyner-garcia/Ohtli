import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/home/domain/repositories/home_repository.dart';
import 'package:Ohtli/features/home/presentation/viewmodels/home_providers.dart';

class SwipeState {
  final int currentIndex;
  final Map<String, bool> preferences;

  SwipeState({
    this.currentIndex = 0,
    this.preferences = const {},
  });

  SwipeState copyWith({
    int? currentIndex,
    Map<String, bool>? preferences,
  }) {
    return SwipeState(
      currentIndex: currentIndex ?? this.currentIndex,
      preferences: preferences ?? this.preferences,
    );
  }
}

class SwipeViewModel extends StateNotifier<SwipeState> {
  final HomeRepository _repository;

  SwipeViewModel(this._repository) : super(SwipeState());

  void onSwipe(int index, bool liked, String category) {
    final newPrefs = Map<String, bool>.from(state.preferences);
    newPrefs[category] = liked;

    state = state.copyWith(
      currentIndex: index + 1,
      preferences: newPrefs,
    );
  }

  Future<void> savePreferences() async {
    // Lógica para guardar en el repositorio/backend
  }
}

final swipeViewModelProvider =
    StateNotifierProvider<SwipeViewModel, SwipeState>((ref) {
  return SwipeViewModel(ref.watch(homeRepositoryProvider));
});
