import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pasaporte_model.dart';

class PasaporteRemoteDataSource {
  final SupabaseClient _client;

  PasaporteRemoteDataSource(this._client);

  Future<List<PasaporteModel>> fetchPasaporteData() async {
    return [];
  }
}
