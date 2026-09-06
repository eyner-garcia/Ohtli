import 'package:flutter/material.dart';

import '../common/neo_paper_container.dart';

class BadgeGridItem extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final bool unlocked;
  final String? progreso;
  final String? iconUrl;

  const BadgeGridItem({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.unlocked,
    this.progreso,
    this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: descripcion,
      child: NeoPaperContainer(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: unlocked
                    ? const Color(0xFF84A98C).withOpacity(.16)
                    : const Color(0xFF84A98C).withOpacity(.18),
                border: Border.all(
                  color: unlocked
                      ? const Color(0xFF84A98C)
                      : const Color(0xFF84A98C),
                  width: 2,
                ),
              ),
              child: unlocked && iconUrl != null && iconUrl!.isNotEmpty
                  ? Image.network(
                      iconUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const _BadgeIcon(unlocked: true),
                    )
                  : _BadgeIcon(unlocked: unlocked),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Center(
                child: Text(
                  nombre,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF004046),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              progreso ?? (unlocked ? 'Desbloqueada' : 'Bloqueada'),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 8,
                height: 1,
                color: Color(0xFF8C5C58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final bool unlocked;

  const _BadgeIcon({required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return Icon(
      unlocked ? Icons.stars_rounded : Icons.lock_rounded,
      color: unlocked
          ? const Color(0xFF84A98C)
          : const Color(0xFF84A98C),
      size: 28,
    );
  }
}
