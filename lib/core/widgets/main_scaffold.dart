import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_bottom_navigation_bar.dart';
import 'custom_drawer.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ohtli',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: 'Notificaciones',
              icon: const Icon(Icons.notifications_none_outlined),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                side: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.45),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
