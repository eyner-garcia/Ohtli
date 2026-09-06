import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:Ohtli/features/pasaporte/data/datasources/pasaporte_remote_datasource.dart';
import 'package:Ohtli/features/pasaporte/data/repositories/pasaporte_repository_impl.dart';
import 'package:Ohtli/features/pasaporte/domain/repositories/pasaporte_repository.dart';

final pasaporteRepositoryProvider = Provider<PasaporteRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return PasaporteRepositoryImpl(PasaporteRemoteDataSource(client));
});
