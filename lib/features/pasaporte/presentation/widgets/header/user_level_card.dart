import 'package:flutter/material.dart';

import '../common/neo_paper_container.dart';

class UserLevelCard extends StatelessWidget {
  final String userName;
  final String? photoUrl;
  final int nivel;
  final int xpTotal;
  final int xpSiguienteNivel;

  const UserLevelCard({
    super.key,
    required this.userName,
    required this.photoUrl,
    required this.nivel,
    required this.xpTotal,
    required this.xpSiguienteNivel,
  });

  @override
  Widget build(BuildContext context) {
    final progress = xpSiguienteNivel <= 0
        ? 1.0
        : (xpTotal / xpSiguienteNivel).clamp(0.0, 1.0);

    final initials = _initials(userName);
    final fotoUrl = photoUrl?.trim();

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: PassportPalette.gold,
              width: 4,
            ),
          ),
          child: CircleAvatar(
            radius: 34,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            backgroundImage: (fotoUrl != null && fotoUrl.isNotEmpty)
                ? NetworkImage(fotoUrl)
                : null,
            child: (fotoUrl == null || fotoUrl.isEmpty)
                ? Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: PassportPalette.leather,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 68,
          height: 76,
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: PassportPalette.leatherDark,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'NIVEL',
                style: TextStyle(
                  color: PassportPalette.paper,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                nivel.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: PassportPalette.paper,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: NeoPaperContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$xpTotal XP',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: PassportPalette.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'de $xpSiguienteNivel XP',
                  style: const TextStyle(
                    fontSize: 11,
                    color: PassportPalette.muted,
                  ),
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    color: PassportPalette.gold,
                    backgroundColor:
                        PassportPalette.gold.withOpacity(.18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _initials(String value) {
    final parts = value
        .trim()
        .split(RegExp(r'\\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) return 'U';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}
