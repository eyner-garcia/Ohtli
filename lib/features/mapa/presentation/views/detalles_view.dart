import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/route_entity.dart';

class DetallesMapaView extends StatelessWidget {
  final RouteEntity? route;

  const DetallesMapaView({super.key, this.route});

  @override
  Widget build(BuildContext context) {
    final routeTitle = route?.title ?? 'Ruta del Sol';
    final duration = route?.duration ?? '1h 45m';
    final distance = route?.distance ?? '3.2 km';
    final difficulty = route?.difficulty ?? 'Media';
    final steps = route?.steps.isNotEmpty == true
        ? route!.steps
        : [
            RouteStepEntity(stepNumber: 1, instruction: 'Sal de la Plaza de Armas hacia el noreste', subInstruction: 'Camina 200m hasta Av. El Sol'),
            RouteStepEntity(stepNumber: 2, instruction: 'Gira a la derecha en Av. El Sol', subInstruction: 'Camina 500m y toma el desvío a Sacsayhuamán'),
            RouteStepEntity(stepNumber: 3, instruction: 'Sube por el Sendero Sagrado', subInstruction: 'Continúa 300m hasta el control de ingreso'),
          ];

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final LatLng centerPoint = route?.polylinePoints.isNotEmpty == true
        ? route!.polylinePoints.first
        : const LatLng(12.9261, -85.9181);

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
                color: isDark ? Colors.grey.shade800 : const Color(0xFFFBF8E3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.chevron_left, color: theme.iconTheme.color),
            ),
          ),
        ),
        title: Text(
          routeTitle,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : const Color(0xFFFBF8E3),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.person, color: Colors.grey, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: centerPoint,
                      initialZoom: 13.0,
                      interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.sirius.sirius',
                      ),
                      if (route?.polylinePoints.isNotEmpty == true)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: route!.polylinePoints,
                              color: theme.colorScheme.primary,
                              strokeWidth: 4.5,
                            ),
                          ],
                        ),
                      MarkerLayer(
                        markers: [
                          if (route?.polylinePoints.isNotEmpty == true) ...[
                            Marker(
                              point: route!.polylinePoints.first,
                              width: 30,
                              height: 30,
                              child: const Icon(Icons.trip_origin, color: Color(0xFF004046), size: 24),
                            ),
                            Marker(
                              point: route!.polylinePoints.last,
                              width: 30,
                              height: 30,
                              child: const Icon(Icons.location_pin, color: Color(0xFFFEA94C), size: 30),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    border: Border(
                      bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(label: 'DURACIÓN', value: duration),
                      SizedBox(
                        height: 30,
                        width: 1,
                        child: ColoredBox(color: theme.dividerColor.withValues(alpha: 0.2)),
                      ),
                      _StatItem(label: 'DISTANCIA', value: distance),
                      SizedBox(
                        height: 30,
                        width: 1,
                        child: ColoredBox(color: theme.dividerColor.withValues(alpha: 0.2)),
                      ),
                      _StatItem(label: 'DIFICULTAD', value: difficulty),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Indicaciones Paso a Paso',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...steps.map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark ? Colors.grey.shade800 : const Color(0xFFFBF8E3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${step.stepNumber}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.instruction,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: theme.textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step.subInstruction,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border(top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Iniciando navegación GPS!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004046),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Navegación',
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
