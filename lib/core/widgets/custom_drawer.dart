import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/themes/theme_provider.dart';
import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/perfil/domain/entities/profile.dart';
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
              data: (profile) => _DrawerProfileHeader(
                profile: profile,
                onNavigateAfterPop: _navigateAfterPop,
              ),
              loading: () => const _ProfileSkeleton(),
              error: (err, stack) => _ProfileErrorView(error: err),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: _DrawerMenuList(
                isDarkMode: isDarkMode,
                onNavigateAfterPop: _navigateAfterPop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _DrawerProfileHeader extends ConsumerWidget {
  final Profile profile;
  final void Function(BuildContext, VoidCallback) onNavigateAfterPop;

  const _DrawerProfileHeader({
    required this.profile,
    required this.onNavigateAfterPop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fotoUrl = profile.user.fotoPerfilUrl;
    final initials = profile.user.nombreCompleto.isNotEmpty
        ? profile.user.nombreCompleto[0].toUpperCase()
        : 'U';

    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                onNavigateAfterPop(
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
                    backgroundImage: (fotoUrl != null && fotoUrl.isNotEmpty)
                        ? NetworkImage(fotoUrl)
                        : null,
                    child: (fotoUrl == null || fotoUrl.isEmpty)
                        ? Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : null,
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
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
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
        Positioned(
          top: 0,
          right: 12,
          child: IconButton(
            tooltip: 'Actualizar perfil',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(profileViewModelProvider.notifier).refreshProfile();
            },
          ),
        ),
      ],
    );
  }
}

class _DrawerMenuList extends ConsumerWidget {
  final bool isDarkMode;
  final void Function(BuildContext, VoidCallback) onNavigateAfterPop;

  const _DrawerMenuList({
    required this.isDarkMode,
    required this.onNavigateAfterPop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        ListTile(
          leading: const Icon(Icons.calendar_today_outlined),
          title: const Text('Historial de Viajes'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            onNavigateAfterPop(context, () {
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Configuración de Cuenta'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            onNavigateAfterPop(context, () {
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.star_outline),
          title: const Text('Cambiar a Premium'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            onNavigateAfterPop(context, () {
            });
          },
        ),
        SwitchListTile(
          secondary: Icon(
            isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
          ),
          title: const Text('Modo Oscuro'),
          value: isDarkMode,
          onChanged: (value) {
            ref.read(themeModeNotifierProvider.notifier).toggleTheme(value);
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
    );
  }
}

class _ProfileErrorView extends StatelessWidget {
  final Object error;

  const _ProfileErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Padding(
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

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surfaceContainerHighest,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 150,
          height: 18,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120,
          height: 13,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 20),
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