import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<void> call(String email, String token) async {
    return await repository.verifyOtp(email, token);
  }
}