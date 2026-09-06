import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Ohtli/features/home/domain/entities/destination_entity.dart';

class DetallesScreen extends StatelessWidget {
  final DestinationEntity? destination;

  const DetallesScreen({super.key, this.destination});

  @override
  Widget build(BuildContext context) {
    final title = destination?.title ?? 'Lugar Turístico';
    final location = destination?.location ?? 'Ubicación no disponible';
    final rating = destination?.rating ?? 0.0;
    final reviewsCount = destination?.reviewsCount ?? 0;
    final description = destination?.description.isNotEmpty == true
        ? destination!.description
        : 'Sin descripción disponible para este destino.';

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen Destacada
                Container(
                  height: 300,
                  width: double.infinity,
                  color: isDark ? Colors.grey.shade800 : const Color(0xFFE9ECEF),
                  child: destination?.imageUrl.isNotEmpty == true
                      ? Image.network(
                          destination!.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(Icons.image_outlined, size: 64, color: Colors.grey),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.image_outlined, size: 64, color: Colors.grey),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Ubicación
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            location,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Rating
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 18,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            rating > 0 ? rating.toString() : 'Sin calificación',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (reviewsCount > 0) ...[
                            const SizedBox(width: 4),
                            Text(
                              '($reviewsCount reseñas)',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Descripción
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8) ?? Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Galería
                      const Text(
                        'Galería de Fotos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 100,
                        child: destination?.gallery.isNotEmpty == true
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: destination!.gallery.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    destination!.gallery[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 100,
                                      color: isDark
                                          ? Colors.grey.shade800
                                          : const Color(0xFFE9ECEF),
                                      child: const Center(
                                          child: Icon(Icons.image,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) => Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.grey.shade800
                                        : const Color(0xFFE9ECEF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.image, color: Colors.grey),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 32),
                      // Botón Ver Reseñas
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () => context.push('/resenas', extra: destination?.id),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: theme.dividerColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Ver Reseñas',
                            style: TextStyle(
                              color: theme.textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botón de Regreso (Sticky)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.chevron_left, color: theme.iconTheme.color),
                ),
              ),
            ),
          ),
          // Botón Inferior "Cómo Llegar"
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border(top: BorderSide(color: theme.dividerColor)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción cómo llegar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cómo Llegar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
