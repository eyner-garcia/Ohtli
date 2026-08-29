import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Ohtli/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:Ohtli/features/home/data/datasources/home_remote_datasource.dart';
import 'package:Ohtli/features/home/data/repositories/home_repository_impl.dart';
import 'package:Ohtli/features/home/domain/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return HomeRepositoryImpl(HomeRemoteDataSource(client));
});
