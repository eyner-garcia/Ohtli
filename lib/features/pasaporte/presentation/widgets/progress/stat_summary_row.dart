import 'package:flutter/material.dart';

import '../common/neo_paper_container.dart';

class StatSummaryRow extends StatelessWidget {
  final int departamentos;
  final int totalDepartamentos;
  final int descubrimientos;
  final int sellos;
  final int recompensas;

  const StatSummaryRow({
    super.key,
    required this.departamentos,
    required this.totalDepartamentos,
    required this.descubrimientos,
    required this.sellos,
    required this.recompensas,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_StatData>[
      _StatData(
        icon: Icons.map_outlined,
        value: '$departamentos/$totalDepartamentos',
        label: 'Departamentos',
      ),
      _StatData(
        icon: Icons.explore_outlined,
        value: '$descubrimientos',
        label: 'Descubrimientos',
      ),
      _StatData(
        icon: Icons.verified_outlined,
        value: '$sellos',
        label: 'Sellos',
      ),
      _StatData(
        icon: Icons.card_giftcard_outlined,
        value: '$recompensas',
        label: 'Recompensas',
      ),
    ];

    return NeoPaperContainer(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 4,
      ),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  size: 18,
                  color: PassportPalette.leather,
                ),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: PassportPalette.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.5,
                    color: PassportPalette.muted,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StatData {
  final IconData icon;
  final String value;
  final String label;

  const _StatData({
    required this.icon,
    required this.value,
    required this.label,
  });
}
