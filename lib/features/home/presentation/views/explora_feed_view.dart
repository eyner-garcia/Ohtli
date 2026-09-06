import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:Ohtli/features/perfil/presentation/viewmodels/profile_viewmodel.dart';
import '../viewmodels/explora_viewmodel.dart';
import '../../domain/entities/destination_entity.dart';

class ExploraFeedScreen extends ConsumerStatefulWidget {
  const ExploraFeedScreen({super.key});

  @override
  ConsumerState<ExploraFeedScreen> createState() => _ExploraFeedScreenState();
}

class _ExploraFeedScreenState extends ConsumerState<ExploraFeedScreen> {
  String selectedCategory = 'Todos';

  @override
  Widget build(BuildContext context) {
    final exploraAsync = ref.watch(exploraViewModelProvider);
    final profileAsync = ref.watch(profileViewModelProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Explorar',
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 24,
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
      body: exploraAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
        data: (state) {
          // Combine popular and nearby without duplicates
          final allDestinations = [
            ...state.filteredPopular,
            ...state.filteredNearby,
          ].fold<Map<String, DestinationEntity>>({}, (map, item) {
            map[item.id] = item;
            return map;
          }).values.toList();

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            ref
                                .read(exploraViewModelProvider.notifier)
                                .setSearchQuery(val);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Buscar destinos, cultura...',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories Chips
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _CategoryChip(
                      label: 'Todos',
                      isActive: selectedCategory == 'Todos',
                      onTap: () => setState(() => selectedCategory = 'Todos'),
                    ),
                    _CategoryChip(
                      label: 'Naturaleza',
                      isActive: selectedCategory == 'Naturaleza',
                      onTap: () => setState(() => selectedCategory = 'Naturaleza'),
                    ),
                    _CategoryChip(
                      label: 'Cultura',
                      isActive: selectedCategory == 'Cultura',
                      onTap: () => setState(() => selectedCategory = 'Cultura'),
                    ),
                    _CategoryChip(
                      label: 'Gastronomía',
                      isActive: selectedCategory == 'Gastronomía',
                      onTap: () => setState(() => selectedCategory = 'Gastronomía'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Feed List
              Expanded(
                child: allDestinations.isEmpty
                    ? const Center(
                        child: Text(
                          'No se encontraron destinos disponibles',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: allDestinations.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final dest = allDestinations[index];
                          return _FeedCard(destination: dest);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? (isDark ? Colors.grey.shade200 : const Color(0xFF4A4A4A))
              : theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? (isDark ? Colors.grey.shade200 : const Color(0xFF4A4A4A))
                : theme.dividerColor.withOpacity(0.2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive
                ? (isDark ? Colors.black : Colors.white)
                : theme.textTheme.bodyLarge?.color,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final DestinationEntity destination;

  const _FeedCard({required this.destination});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push('/detalles', extra: destination),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto Placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : const Color(0xFFE9ECEF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: destination.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        destination.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image, color: Colors.grey),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < destination.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            size: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        destination.rating.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    const Spacer(),
                      Text(
                        destination.distance.isNotEmpty
                            ? destination.distance
                            : '12 km',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
