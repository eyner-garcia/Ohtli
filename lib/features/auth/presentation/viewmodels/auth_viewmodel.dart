import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/send_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/update_password_usecase.dart';

part 'auth_viewmodel.g.dart';
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSource(ref.watch(supabaseClientProvider));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
}
@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
LogoutUseCase logoutUseCase(LogoutUseCaseRef ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
SendPasswordResetUseCase sendPasswordResetUseCase(SendPasswordResetUseCaseRef ref) {
  return SendPasswordResetUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
VerifyOtpUseCase verifyOtpUseCase(VerifyOtpUseCaseRef ref) {
  return VerifyOtpUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdatePasswordUseCase updatePasswordUseCase(UpdatePasswordUseCaseRef ref) {
  return UpdatePasswordUseCase(ref.watch(authRepositoryProvider));
}
@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  @override
  FutureOr<UserEntity?> build() async {
    final client = ref.watch(supabaseClientProvider);
    final session = client.auth.currentSession;

    if (session != null) {
      try {
        final data = await client
            .from('usuarios')
            .select()
            .eq('auth_id', session.user.id)
            .single();
        return UserModel.fromJson(data);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final loginUseCase = ref.read(loginUseCaseProvider);
      return await loginUseCase(email, password);
    });
  }

  Future<void> signUp(String email, String password, String nombreCompleto) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final signUpUseCase = ref.read(signUpUseCaseProvider);
      final loginUseCase = ref.read(loginUseCaseProvider);

      await signUpUseCase(email, password, nombreCompleto);
      return await loginUseCase(email, password);
    });
  }

  Future<bool> sendPasswordResetCode(String email) async {
    state = const AsyncValue.loading();
    bool success = false;
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(sendPasswordResetUseCaseProvider);
      await useCase(email);
      success = true;
      return state.value;
    });
    return success;
  }

  Future<bool> verifyResetCode(String email, String token) async {
    state = const AsyncValue.loading();
    bool success = false;
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(verifyOtpUseCaseProvider);
      await useCase(email, token);
      success = true;
      return state.value;
    });
    return success;
  }

  Future<bool> updatePassword(String newPassword) async {
    state = const AsyncValue.loading();
    bool success = false;
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(updatePasswordUseCaseProvider);
      await useCase(newPassword);
      success = true;
      return state.value;
    });
    return success;
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final logoutUseCase = ref.read(logoutUseCaseProvider);
      await logoutUseCase();
      return null;
    });
  }
}