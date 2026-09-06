import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/review_entity.dart';
import 'home_providers.dart';

part 'reseñas_viewmodel.g.dart';

@riverpod
class ResenasViewModel extends _$ResenasViewModel {
  @override
  FutureOr<List<ReviewEntity>> build(String destinationId) async {
    final getReviews = ref.watch(getDestinationReviewsProvider);

    try {
      final reviews = await getReviews(destinationId);
      return reviews; // Return actual reviews from DB (empty if none registered)
    } catch (_) {
      return [];
    }
  }
}
