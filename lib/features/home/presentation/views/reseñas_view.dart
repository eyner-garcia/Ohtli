import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:Ohtli/features/perfil/presentation/viewmodels/profile_viewmodel.dart';
import '../viewmodels/reseñas_viewmodel.dart';

class ResenasScreen extends ConsumerWidget {
  final String? destinationId;

  const ResenasScreen({super.key, this.destinationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(resenasViewModelProvider(destinationId ?? ''));
    final profileAsync = ref.watch(profileViewModelProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : const Color(0xFFF1F3F4),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.chevron_left, color: theme.iconTheme.color),
            ),
          ),
        ),
        title: Text(
          'Reseñas',
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: profileAsync.when(
              data: (profile) => CircleAvatar(
                radius: 20,
                backgroundImage: profile.user.fotoPerfilUrl != null &&
                        profile.user.fotoPerfilUrl!.isNotEmpty
                    ? NetworkImage(profile.user.fotoPerfilUrl!)
                    : null,
                child: profile.user.fotoPerfilUrl == null ||
                        profile.user.fotoPerfilUrl!.isEmpty
                    ? Text(
                        profile.user.nombreCompleto.isNotEmpty
                            ? profile.user.nombreCompleto[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    : null,
              ),
              loading: () => const CircleAvatar(
                radius: 20,
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              error: (_, __) => CircleAvatar(
                radius: 20,
                backgroundColor: isDark ? Colors.grey.shade800 : const Color(0xFFE9ECEF),
                child: const Icon(Icons.person, color: Colors.grey, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: reviewsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Error al cargar reseñas: $err',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
        data: (reviews) {
          final avgRating = reviews.isNotEmpty
              ? (reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length)
              : 0.0;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating Summary Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                avgRating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    index < avgRating.floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 14,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${reviews.length} reseñas',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 32),
                          const Expanded(
                            child: Column(
                              children: [
                                _RatingBar(label: '5', value: 0.85, percentage: '85%'),
                                _RatingBar(label: '4', value: 0.10, percentage: '10%'),
                                _RatingBar(label: '3', value: 0.03, percentage: '3%'),
                                _RatingBar(label: '2', value: 0.01, percentage: '1%'),
                                _RatingBar(label: '1', value: 0.01, percentage: '1%'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Divider(color: theme.dividerColor),
                      const SizedBox(height: 16),
                      // Reviews List
                      if (reviews.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              children: [
                                Icon(Icons.rate_review_outlined,
                                    size: 48, color: Colors.grey.shade400),
                                const SizedBox(height: 12),
                                const Text(
                                  'Aún no hay reseñas para este lugar.\n¡Sé el primero en calificarlo!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...reviews.map(
                          (rev) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _ReviewCard(
                              userName: rev.userName,
                              date: rev.date,
                              content: rev.content,
                              rating: rev.rating,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final String label;
  final double value;
  final String percentage;

  const _RatingBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: theme.dividerColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text(
              percentage,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String userName;
  final String date;
  final String content;
  final double rating;

  const _ReviewCard({
    required this.userName,
    required this.date,
    required this.content,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : const Color(0xFFE9ECEF),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.grey, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating.floor() ? Icons.star : Icons.star_border,
                    size: 14,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8) ??
                  Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
