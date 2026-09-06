// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseClientHash() => r'deacb610ba5a2a6164a9836f0ed10a1e9de80426';

/// See also [supabaseClient].
@ProviderFor(supabaseClient)
final supabaseClientProvider = Provider<SupabaseClient>.internal(
  supabaseClient,
  name: r'supabaseClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseClientRef = ProviderRef<SupabaseClient>;
String _$authRemoteDataSourceHash() =>
    r'a1852db1ba46ab4549f67dd5029f0b63cea26f54';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRemoteDataSourceRef = ProviderRef<AuthRemoteDataSource>;
String _$authRepositoryHash() => r'3a186f8116a3be371350708c0d3b088545a1a39e';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$loginUseCaseHash() => r'c19591da812e8b7ab7dd1235ae74be1fb38cb6ae';

/// See also [loginUseCase].
@ProviderFor(loginUseCase)
final loginUseCaseProvider = Provider<LoginUseCase>.internal(
  loginUseCase,
  name: r'loginUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoginUseCaseRef = ProviderRef<LoginUseCase>;
String _$signUpUseCaseHash() => r'6102e9062e66fa5d0d7b9cdc4a0298389c575457';

/// See also [signUpUseCase].
@ProviderFor(signUpUseCase)
final signUpUseCaseProvider = Provider<SignUpUseCase>.internal(
  signUpUseCase,
  name: r'signUpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signUpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignUpUseCaseRef = ProviderRef<SignUpUseCase>;
String _$logoutUseCaseHash() => r'54b86cd9d567dee222a0e34f4473674309576fe0';

/// See also [logoutUseCase].
@ProviderFor(logoutUseCase)
final logoutUseCaseProvider = Provider<LogoutUseCase>.internal(
  logoutUseCase,
  name: r'logoutUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$logoutUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogoutUseCaseRef = ProviderRef<LogoutUseCase>;
String _$sendPasswordResetUseCaseHash() =>
    r'3be6e3cbe40d719c27ea3c60f70d423c6f948926';

/// See also [sendPasswordResetUseCase].
@ProviderFor(sendPasswordResetUseCase)
final sendPasswordResetUseCaseProvider =
    Provider<SendPasswordResetUseCase>.internal(
  sendPasswordResetUseCase,
  name: r'sendPasswordResetUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendPasswordResetUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SendPasswordResetUseCaseRef = ProviderRef<SendPasswordResetUseCase>;
String _$verifyOtpUseCaseHash() => r'd0052593eb2b9296693aca539f48d67467ac99f7';

/// See also [verifyOtpUseCase].
@ProviderFor(verifyOtpUseCase)
final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>.internal(
  verifyOtpUseCase,
  name: r'verifyOtpUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$verifyOtpUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VerifyOtpUseCaseRef = ProviderRef<VerifyOtpUseCase>;
String _$updatePasswordUseCaseHash() =>
    r'6e5ca9ff0f594d627b907593660b0d2b051180f5';

/// See also [updatePasswordUseCase].
@ProviderFor(updatePasswordUseCase)
final updatePasswordUseCaseProvider = Provider<UpdatePasswordUseCase>.internal(
  updatePasswordUseCase,
  name: r'updatePasswordUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updatePasswordUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdatePasswordUseCaseRef = ProviderRef<UpdatePasswordUseCase>;
String _$authViewModelHash() => r'b9cf26167cd4da69b9e3046aba2b648cba0251df';

/// See also [AuthViewModel].
@ProviderFor(AuthViewModel)
final authViewModelProvider =
    AsyncNotifierProvider<AuthViewModel, UserEntity?>.internal(
  AuthViewModel.new,
  name: r'authViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthViewModel = AsyncNotifier<UserEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
