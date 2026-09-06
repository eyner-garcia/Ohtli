import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/passport_snapshot.dart';
import '../models/cultural_content_model.dart';
import '../models/department_poi_model.dart';
import '../models/reward_redemption_model.dart';
import '../models/stamp_passport_result_model.dart';

abstract class PassportRemoteDataSource {
  Future<StampPassportResultModel> stampPassport({
    required String pin,
  });

  Future<List<RewardRedemptionModel>> getRewardRedemptions();

  Future<PassportSnapshot> getPassportSnapshot();

  Future<List<DepartmentPoiModel>> getDepartmentPois({
    required String departmentId,
  });
}

class PassportRemoteDataSourceImpl implements PassportRemoteDataSource {
  final SupabaseClient supabase;

  const PassportRemoteDataSourceImpl({
    required this.supabase,
  });

  Future<String> _currentUsuarioId() async {
    final authUser = supabase.auth.currentUser;

    if (authUser == null) {
      throw StateError('Usuario no autenticado');
    }

    final row = await supabase
        .from('usuarios')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();

    return row['id'].toString();
  }

  @override
  Future<StampPassportResultModel> stampPassport({
    required String pin,
  }) async {
    final response = await supabase.rpc(
      'stamp_passport',
      params: {
        'p_codigo_pin': pin,
      },
    );

    return StampPassportResultModel.fromJson(
      Map<String, dynamic>.from(response as Map),
    );
  }

  @override
  Future<List<RewardRedemptionModel>> getRewardRedemptions() async {
    final usuarioId = await _currentUsuarioId();

    final response = await supabase
        .from('regalias_canjes')
        .select('''
          id,
          codigo_canje,
          estado,
          expira_en,
          utilizada_en,
          creado_en,
          regalias!inner(
            id,
            titulo,
            descripcion,
            tipo_beneficio,
            valor_beneficio,
            descripcion_beneficio,
            frecuencia_recompensa,
            expira_en
          )
        ''')
        .eq('usuario_id', usuarioId)
        .order('creado_en', ascending: false);

    return (response as List)
        .map(
          (row) => RewardRedemptionModel.fromJson(
            Map<String, dynamic>.from(row as Map),
          ),
        )
        .toList();
  }

  @override
  Future<PassportSnapshot> getPassportSnapshot() async {
    final usuarioId = await _currentUsuarioId();

    final userFuture = supabase
        .from('usuarios')
        .select('nombre_completo, foto_perfil_url, xp_acumulada')
        .eq('id', usuarioId)
        .single();

    final departmentsFuture = supabase
        .from('departamentos')
        .select('id, nombre')
        .order('nombre');

    final stampsFuture = supabase
        .from('pasaporte_sellos')
        .select('''
          poi_id,
          puntos_interes!inner(
            departamento_id
          )
        ''')
        .eq('usuario_id', usuarioId);

    final badgesFuture = supabase
        .from('insignias')
        .select(
          'id, nombre, descripcion, icono_url, valor_requisito',
        )
        .eq('es_activa', true)
        .order('creado_en');

    final userBadgesFuture = supabase
        .from('usuarios_insignias')
        .select('insignia_id')
        .eq('usuario_id', usuarioId);

    final base = await Future.wait<dynamic>([
      userFuture,
      departmentsFuture,
      stampsFuture,
      badgesFuture,
      userBadgesFuture,
    ]);

    final user = Map<String, dynamic>.from(base[0] as Map);
    final departmentRows = List<dynamic>.from(base[1] as List);
    final stampRows = List<dynamic>.from(base[2] as List);
    final badgeRows = List<dynamic>.from(base[3] as List);
    final userBadgeRows = List<dynamic>.from(base[4] as List);

    if (departmentRows.isEmpty) {
      throw StateError('No hay departamentos disponibles.');
    }

    final visitsByDepartment = <String, int>{};
    final poisByDepartment = <String, Set<String>>{};

    for (final raw in stampRows) {
      final row = Map<String, dynamic>.from(raw as Map);
      final poiRaw = row['puntos_interes'];
      if (poiRaw is! Map) continue;

      final poi = Map<String, dynamic>.from(poiRaw);
      final departmentId = poi['departamento_id']?.toString();
      final poiId = row['poi_id']?.toString();

      if (departmentId == null || departmentId.isEmpty) continue;

      visitsByDepartment.update(
        departmentId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );

      if (poiId != null && poiId.isNotEmpty) {
        poisByDepartment
            .putIfAbsent(departmentId, () => <String>{})
            .add(poiId);
      }
    }

    final departmentSnapshots =
        await Future.wait<PassportDepartmentSnapshot>(
      departmentRows.map((raw) async {
        final row = Map<String, dynamic>.from(raw as Map);
        final id = row['id'].toString();

        int percentage = 0;

        try {
          final progressResponse = await supabase.rpc(
            'get_department_progress',
            params: {
              'p_usuario_id': usuarioId,
              'p_departamento_id': id,
            },
          );

          if (progressResponse is Map) {
            final progress =
                Map<String, dynamic>.from(progressResponse);
            percentage = _asInt(
              progress['porcentaje'] ??
                  progress['porcentaje_actual'] ??
                  progress['percentage'],
            );
          }
        } catch (_) {
          percentage = 0;
        }

        return PassportDepartmentSnapshot(
          id: id,
          name: row['nombre']?.toString() ?? 'Departamento',
          percentage: percentage.clamp(0, 100),
          completed: percentage >= 100,
          visits: visitsByDepartment[id] ?? 0,
          discoveries: poisByDepartment[id]?.length ?? 0,
        );
      }),
    );

    final unlockedBadgeIds = userBadgeRows
        .map(
          (raw) => Map<String, dynamic>.from(raw as Map)[
                  'insignia_id']
              ?.toString(),
        )
        .whereType<String>()
        .toSet();

    final badgeSnapshots = badgeRows.map((raw) {
      final row = Map<String, dynamic>.from(raw as Map);
      final id = row['id'].toString();

      return PassportBadgeSnapshot(
        id: id,
        name: row['nombre']?.toString() ?? 'Insignia',
        description: row['descripcion']?.toString() ?? '',
        iconUrl: row['icono_url']?.toString(),
        requirementValue: _asInt(row['valor_requisito']),
        unlocked: unlockedBadgeIds.contains(id),
      );
    }).toList();

    final culturalContents = await _getUnlockedCulturalContent(
      usuarioId,
    );

    return PassportSnapshot(
      userName: user['nombre_completo']?.toString() ?? 'Usuario',
      photoUrl: user['foto_perfil_url']?.toString(),
      xpTotal: _asInt(user['xp_acumulada']),
      totalStamps: stampRows.length,
      departments: departmentSnapshots,
      badges: badgeSnapshots,
      culturalContents: culturalContents,
    );
  }

  @override
  Future<List<DepartmentPoiModel>> getDepartmentPois({
    required String departmentId,
  }) async {
    final usuarioId = await _currentUsuarioId();

    final results = await Future.wait<dynamic>([
      supabase
          .from('puntos_interes')
          .select('''
            id,
            nombre,
            descripcion,
            direccion,
            foto_portada_url,
            promedio_calificacion,
            total_resenas
          ''')
          .eq('departamento_id', departmentId)
          .eq('es_activo', true)
          .order('nombre'),
      supabase
          .from('pasaporte_sellos')
          .select('poi_id')
          .eq('usuario_id', usuarioId),
    ]);

    final poiRows = List<dynamic>.from(results[0] as List);
    final visitedPoiIds = List<dynamic>.from(results[1] as List)
        .map(
          (raw) => Map<String, dynamic>.from(raw as Map)['poi_id']
              ?.toString(),
        )
        .whereType<String>()
        .toSet();

    return poiRows
        .map(
          (raw) {
            final row = Map<String, dynamic>.from(raw as Map);
            final id = row['id'].toString();

            return DepartmentPoiModel.fromJson(
              row,
              visited: visitedPoiIds.contains(id),
            );
          },
        )
        .toList();
  }

  Future<List<CulturalContentModel>> _getUnlockedCulturalContent(
    String usuarioId,
  ) async {
    final response = await supabase
        .from('usuarios_contenidos_culturales')
        .select('''
          contenidos_culturales!inner(
            id,
            titulo,
            imagen_url,
            descripcion,
            tipo_contenido,
            es_introductorio,
            requisito_porcentaje,
            orden
          )
        ''')
        .eq('usuario_id', usuarioId);

    final items = <CulturalContentModel>[];

    for (final raw in response as List) {
      final row = Map<String, dynamic>.from(raw as Map);
      final nested = row['contenidos_culturales'];

      if (nested is Map) {
        items.add(
          CulturalContentModel.fromJson(
            Map<String, dynamic>.from(nested),
          ),
        );
      }
    }

    items.sort((a, b) => a.order.compareTo(b.order));
    return items;
  }

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
