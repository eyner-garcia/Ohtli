import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/datasources/passport_remote_datasource.dart';
import '../../../data/repositories/passport_repository.dart';
import '../../../domain/repositories/passport_repository.dart';
import '../../../domain/usecases/stamp_passport_usecase.dart';

final passportRemoteDataSourceProvider =
Provider<PassportRemoteDataSource>((ref) {
  return PassportRemoteDataSourceImpl(
    supabase: Supabase.instance.client,
  );
});

final passportRepositoryProvider =
Provider<PassportRepository>((ref) {
  return PassportRepositoryImpl(
    remoteDataSource: ref.watch(
      passportRemoteDataSourceProvider,
    ),
  );
});

final stampPassportUseCaseProvider =
Provider<StampPassportUseCase>((ref) {
  return StampPassportUseCase(
    repository: ref.watch(
      passportRepositoryProvider,
    ),
  );
});