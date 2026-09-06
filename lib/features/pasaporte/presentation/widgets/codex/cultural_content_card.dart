import 'package:flutter/material.dart';
import '../common/neo_paper_container.dart';

class CulturalContentCard extends StatelessWidget {
  final String titulo;
  final String tipo;
  final String? resumen;
  final String? imagenUrl;
  final VoidCallback? onTap;

  const CulturalContentCard({
    super.key,
    required this.titulo,
    required this.tipo,
    this.resumen,
    this.imagenUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: NeoPaperContainer(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 82,
                height: 82,
                child: imagenUrl != null && imagenUrl!.isNotEmpty
                    ? Image.network(
                  imagenUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const _CulturalPlaceholder(),
                )
                    : const _CulturalPlaceholder(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tipo.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 8,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF8A531D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2C2118),
                    ),
                  ),
                  if (resumen != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      resumen!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF776B5D),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF70451F),
            ),
          ],
        ),
      ),
    );
  }
}

class _CulturalPlaceholder extends StatelessWidget {
  const _CulturalPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFE2D4B8),
      child: Center(
        child: Icon(
          Icons.auto_stories_rounded,
          color: const Color(0xFF70451F),
          size: 30,
        ),
      ),
    );
  }
}
