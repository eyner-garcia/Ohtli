import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/themes/theme_provider.dart';
import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/perfil/presentation/viewmodels/profile_viewmodel.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  void _navigateAfterPop(BuildContext context, VoidCallback onNavigate) {
    Navigator.of(context).pop();
    onNavigate();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final isDarkMode = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    final profileAsync = ref.watch(profileViewModelProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            profileAsync.when(
              data: (profile) => Stack(
                children: [
                  Column(
                    children: [
                      // Avatar e info clickeables para ver perfil
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _navigateAfterPop(
                            context,
                                () => context.pushNamed('profile'),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                              child: Text(
                                profile.user.nombreCompleto.isNotEmpty
                                    ? profile.user.nombreCompleto[0]
                                    .toUpperCase()
                                    : 'U',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              profile.user.nombreCompleto,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              profile.user.correo,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botón para editar perfil
                      TextButton(
                        onPressed: () {
                          _navigateAfterPop(
                            context,
                                () => context.pushNamed(
                              'edit_profile',
                              extra: profile,
                            ),
                          );
                        },
                        child: const Text(
                          'Editar Perfil',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Tarjeta de estadísticas
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .dividerColor
                                .withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              number: '${profile.placesCount}',
                              label: 'Lugares',
                            ),
                            _StatItem(
                              number: '${profile.routesCount}',
                              label: 'Rutas',
                            ),
                            _StatItem(
                              number: '${profile.badgesCount}',
                              label: 'Insignias',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 🔄 REFRESH
                  Positioned(
                    top: 0,
                    right: 12,
                    child: IconButton(
                      tooltip: 'Actualizar perfil',
                      icon: const Icon(Icons.refresh_rounded),
                      onPressed: () {
                        ref
                            .read(profileViewModelProvider.notifier)
                            .refreshProfile();
                      },
                    ),
                  ),
                ],
              ),
              loading: () => const _ProfileSkeleton(),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Error al cargar perfil',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Opciones de Menú
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: const Text('Historial de Viajes'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _navigateAfterPop(context, () {
                        // TODO: context.pushNamed('trip_history');
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Configuración de Cuenta'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _navigateAfterPop(context, () {
                        // TODO: context.pushNamed('settings');
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star_outline),
                    title: const Text('Cambiar a Premium'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _navigateAfterPop(context, () {
                        // TODO: context.pushNamed('premium');
                      });
                    },
                  ),
                  SwitchListTile(
                    secondary: Icon(
                      isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    title: const Text('Modo Oscuro'),
                    value: isDarkMode,
                    onChanged: (value) {
                      ref
                          .read(themeModeNotifierProvider.notifier)
                          .toggleTheme(value);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.redAccent),
                    title: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.redAccent,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      ref.read(authViewModelProvider.notifier).logout();
                    },
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

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// SKELETON COMPONENTS
// -----------------------------------------------------------------------------

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surfaceContainerHighest,
          ),
        ),

        const SizedBox(height: 12),

        // Nombre
        Container(
          width: 150,
          height: 18,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
        ),

        const SizedBox(height: 8),

        // Correo
        Container(
          width: 120,
          height: 13,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
        ),

        const SizedBox(height: 14),

        // Editar perfil
        Container(
          width: 100,
          height: 16,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
        ),

        const SizedBox(height: 20),

        // Estadísticas
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SkeletonStat(),
              _SkeletonStat(),
              _SkeletonStat(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonStat extends StatelessWidget {
  const _SkeletonStat();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: 24,
          height: 16,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 45,
          height: 12,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}