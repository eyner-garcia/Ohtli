import 'package:flutter/material.dart';

import '../../viewmodels/passport_viewmodel.dart';
import '../../widgets/common/neo_paper_container.dart';
import '../../widgets/progress/department_map_card.dart';
import '../../widgets/progress/department_tile.dart';
import '../../widgets/progress/stat_summary_row.dart';

class PassportProgressTab extends StatelessWidget {
  final PassportState state;
  final ValueChanged<PassportDepartmentState>? onDepartmentTap;
  final Future<void> Function() onRefresh;

  const PassportProgressTab({
    super.key,
    required this.state,
    required this.onRefresh,
    this.onDepartmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          16,
          14,
          16,
          110,
        ),
        children: [
          if (state.passportLoading && state.departamentos.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(),
              ),
            )
          else if (state.passportError != null &&
              state.departamentos.isEmpty)
            NeoPaperContainer(
              child: Column(
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 38),
                  const SizedBox(height: 8),
                  const Text(
                    'No pudimos cargar tu progreso.',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: onRefresh,
                    child: const Text('REINTENTAR'),
                  ),
                ],
              ),
            )
          else ...[
            DepartmentMapCard(
              departments: state.departamentos,
              onTap: onDepartmentTap,
            ),
            const SizedBox(height: 14),
            StatSummaryRow(
              departamentos: state.departamentosDescubiertos,
              totalDepartamentos: state.departamentos.length,
              descubrimientos: _totalDescubrimientos,
              sellos: state.totalSellos,
              recompensas: state.rewardRedemptions
                  .where((reward) => reward.isAvailable)
                  .length,
            ),
            const SizedBox(height: 18),
            const Text(
              'Departamentos',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: PassportPalette.ink,
              ),
            ),
            const SizedBox(height: 10),
            if (state.departamentos.isEmpty)
              const NeoPaperContainer(
                child: Text(
                  'No hay departamentos disponibles.',
                  style: TextStyle(
                    color: PassportPalette.muted,
                  ),
                ),
              )
            else
              ...state.departamentos.map(
                (department) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DepartmentTile(
                    department: department,
                    onTap: onDepartmentTap == null
                        ? null
                        : () => onDepartmentTap!(department),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  int get _totalDescubrimientos {
    return state.departamentos.fold(
      0,
      (total, department) =>
          total + department.descubrimientos,
    );
  }
}
