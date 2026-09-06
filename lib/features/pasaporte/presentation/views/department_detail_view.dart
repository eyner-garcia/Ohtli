import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/department_poi.dart';
import '../viewmodels/passport_viewmodel.dart';
import '../viewmodels/providers/passport_provider.dart';
import '../widgets/common/neo_paper_container.dart';

class DepartmentDetailView extends ConsumerStatefulWidget {
  final PassportDepartmentState department;

  const DepartmentDetailView({
    super.key,
    required this.department,
  });

  @override
  ConsumerState<DepartmentDetailView> createState() =>
      _DepartmentDetailViewState();
}

class _DepartmentDetailViewState
    extends ConsumerState<DepartmentDetailView> {
  late Future<List<DepartmentPoi>> _pois;

  @override
  void initState() {
    super.initState();
    _pois = _loadPois();
  }

  Future<List<DepartmentPoi>> _loadPois() {
    return ref.read(passportRepositoryProvider).getDepartmentPois(
          departmentId: widget.department.id,
        );
  }

  Future<void> _refresh() async {
    final future = _loadPois();
    setState(() => _pois = future);
    await future;
  }

  @override
  Widget build(BuildContext context) {
    final department = widget.department;

    return Scaffold(
      backgroundColor: PassportPalette.parchment,
      appBar: AppBar(
        title: Text(department.nombre),
        backgroundColor: PassportPalette.parchment,
        foregroundColor: PassportPalette.ink,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
          children: [
            NeoPaperContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${department.porcentaje}% completado',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: PassportPalette.ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: department.porcentaje / 100,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _Metric(
                          icon: Icons.route_rounded,
                          value: '${department.visitas}',
                          label: 'Visitas',
                        ),
                      ),
                      Expanded(
                        child: _Metric(
                          icon: Icons.explore_outlined,
                          value: '${department.descubrimientos}',
                          label: 'Descubrimientos',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lugares por descubrir',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: PassportPalette.ink,
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<DepartmentPoi>>(
              future: _pois,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 36),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return NeoPaperContainer(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.cloud_off_outlined,
                          size: 38,
                          color: PassportPalette.muted,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'No pudimos cargar los lugares de este departamento.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: PassportPalette.ink,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _refresh,
                          child: const Text('REINTENTAR'),
                        ),
                      ],
                    ),
                  );
                }

                final pois = snapshot.data ?? const <DepartmentPoi>[];

                if (pois.isEmpty) {
                  return const NeoPaperContainer(
                    child: Text(
                      'Aún no hay puntos de interés activos para este departamento.',
                      style: TextStyle(color: PassportPalette.muted),
                    ),
                  );
                }

                return Column(
                  children: pois
                      .map(
                        (poi) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _PoiCard(poi: poi),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _Metric({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: PassportPalette.leather),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: PassportPalette.ink,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: PassportPalette.muted,
          ),
        ),
      ],
    );
  }
}

class _PoiCard extends StatelessWidget {
  final DepartmentPoi poi;

  const _PoiCard({
    required this.poi,
  });

  @override
  Widget build(BuildContext context) {
    return NeoPaperContainer(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 88,
              height: 88,
              color: PassportPalette.parchment,
              child: poi.coverPhotoUrl != null &&
                      poi.coverPhotoUrl!.isNotEmpty
                  ? Image.network(
                      poi.coverPhotoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.landscape_outlined,
                        color: PassportPalette.muted,
                      ),
                    )
                  : const Icon(
                      Icons.landscape_outlined,
                      color: PassportPalette.muted,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        poi.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: PassportPalette.ink,
                        ),
                      ),
                    ),
                    Icon(
                      poi.visited
                          ? Icons.verified_rounded
                          : Icons.lock_open_rounded,
                      size: 18,
                      color: poi.visited
                          ? PassportPalette.green
                          : PassportPalette.muted,
                    ),
                  ],
                ),
                if (poi.address != null && poi.address!.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    poi.address!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: PassportPalette.muted,
                    ),
                  ),
                ],
                if (poi.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    poi.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.3,
                      color: PassportPalette.muted,
                    ),
                  ),
                ],
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 15,
                      color: PassportPalette.gold,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      poi.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: PassportPalette.ink,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '(${poi.reviewCount})',
                      style: const TextStyle(
                        fontSize: 9,
                        color: PassportPalette.muted,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      poi.visited ? 'Visitado' : 'Pendiente',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: poi.visited
                            ? PassportPalette.green
                            : PassportPalette.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
