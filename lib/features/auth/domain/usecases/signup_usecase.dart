import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);

  Future<void> call(String email, String password, String nombreCompleto) {
    return _repository.signUpWithEmail(email: email, password: password, nombreCompleto: nombreCompleto);
  }
}