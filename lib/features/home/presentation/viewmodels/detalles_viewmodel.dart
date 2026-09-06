import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/destination_entity.dart';
import 'home_providers.dart';

part 'detalles_viewmodel.g.dart';

@riverpod
class DetallesViewModel extends _$DetallesViewModel {
  @override
  FutureOr<DestinationEntity?> build(String? destinationId) async {
    if (destinationId == null || destinationId.isEmpty) {
      return null;
    }

    final getDetails = ref.watch(getDestinationDetailsProvider);
    try {
      return await getDetails(destinationId);
    } catch (_) {
      return null;
    }
  }
}
