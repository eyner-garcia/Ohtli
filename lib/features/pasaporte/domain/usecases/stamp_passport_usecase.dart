import '../entities/stamp_passport_result.dart';
import '../repositories/passport_repository.dart';

class StampPassportUseCase {
  final PassportRepository repository;

  const StampPassportUseCase({
    required this.repository,
  });

  Future<StampPassportResult> call({
    required String pin,
  }) {
    return repository.stampPassport(
      pin: pin,
    );
  }
}