import 'package:flutter/material.dart';

import '../../viewmodels/passport_viewmodel.dart';
import '../common/neo_paper_container.dart';

class DepartmentTile extends StatelessWidget {
  final PassportDepartmentState department;
  final VoidCallback? onTap;

  const DepartmentTile({
    super.key,
    required this.department,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = department.completado
        ? PassportPalette.gold
        : department.porcentaje == 0
        ? PassportPalette.locked
        : department.porcentaje >= 50
        ? PassportPalette.green
        : PassportPalette.orange;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: NeoPaperContainer(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 9,
              height: 40,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    department.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: PassportPalette.ink,
                    ),
                  ),
                  Text(
                    '${department.visitas} visitas · '
                        '${department.descubrimientos} descubrimientos',
                    style: const TextStyle(
                      fontSize: 10,
                      color: PassportPalette.muted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${department.porcentaje}%',
              style: TextStyle(
                color: c,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}