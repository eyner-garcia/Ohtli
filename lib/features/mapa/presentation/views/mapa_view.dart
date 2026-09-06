import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import '../viewmodels/mapa_viewmodel.dart';
import '../../domain/entities/map_point_entity.dart';
import '../../domain/entities/route_entity.dart';
import '../../../home/domain/entities/destination_entity.dart';

class MapaView extends ConsumerStatefulWidget {
  const MapaView({super.key});

  @override
  ConsumerState<MapaView> createState() => _MapaViewState();
}

class _MapaViewState extends ConsumerState<MapaView> {
  final MapController mapController = MapController();
  LatLng initialCenter = const LatLng(12.9261, -85.9181); // Default: Matagalpa, Nicaragua
  LatLng? userLocation;
  bool isLoadingLocation = true;
  StreamSubscription<Position>? _positionStreamSubscription;
  RouteEntity? selectedRoute;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _startLocationStream();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final userLatLng = LatLng(position.latitude, position.longitude);
      setState(() {
        initialCenter = userLatLng;
        userLocation = userLatLng;
        isLoadingLocation = false;
      });

      mapController.move(userLatLng, 14.0);
    } catch (_) {
      setState(() => isLoadingLocation = false);
    }
  }

  void _startLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        if (mounted) {
          setState(() {
            userLocation = LatLng(position.latitude, position.longitude);
          });
        }
      },
    );
  }

  Widget _buildCategoryMarker(MapPointEntity point) {
    Color markerColor = const Color(0xFF004046);
    IconData markerIcon = Icons.place;

    final cat = point.category.toLowerCase();
    if (cat.contains('nat') || cat.contains('eco') || cat.contains('parque') || cat.contains('sender')) {
      markerColor = const Color(0xFF84A98C);
      markerIcon = Icons.forest;
    } else if (cat.contains('cult') || cat.contains('trad') || cat.contains('hist') || cat.contains('arte')) {
      markerColor = const Color(0xFF8C5C58);
      markerIcon = Icons.account_balance;
    } else if (cat.contains('gast') || cat.contains('comid') || cat.contains('rest') || cat.contains('café')) {
      markerColor = const Color(0xFFFEA94C);
      markerIcon = Icons.restaurant;
    } else if (cat.contains('aven') || cat.contains('deport') || cat.contains('extre')) {
      markerColor = const Color(0xFF8C5C58);
      markerIcon = Icons.hiking;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: markerColor, width: 2.5),
      ),
      child: Center(
        child: Icon(
          markerIcon,
          color: markerColor,
          size: 20,
        ),
      ),
    );
  }

  void _showPointDetails(BuildContext context, MapPointEntity point) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      point.category.isNotEmpty ? point.category : 'Turismo Sostenible',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                point.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                point.description,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    final destination = DestinationEntity(
                      id: point.id,
                      title: point.title,
                      location: point.description,
                      rating: 4.8,
                      description: point.description,
                      imageUrl: point.imageUrl,
                      latitude: point.latitude,
                      longitude: point.longitude,
                    );
                    context.push('/detalles', extra: destination);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ver Detalles',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapaAsync = ref.watch(mapaViewModelProvider);
    final theme = Theme.of(context);
    mapaAsync.whenData((state) {
      if (selectedRoute == null && state.suggestedRoutes.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            selectedRoute = state.suggestedRoutes.first;
          });
        });
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          mapaAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error al cargar mapa: $err')),
            data: (state) => FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.sirius.sirius',
                ),
                if (selectedRoute != null && selectedRoute!.polylinePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: selectedRoute!.polylinePoints,
                        color: theme.colorScheme.primary,
                        strokeWidth: 5.0,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    if (userLocation != null)
                      Marker(
                        point: userLocation!,
                        width: 48,
                        height: 48,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF004046).withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFF004046),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ...state.points.map((point) {
                      return Marker(
                        point: LatLng(point.latitude, point.longitude),
                        width: 42,
                        height: 42,
                        child: GestureDetector(
                          onTap: () => _showPointDetails(context, point),
                          child: _buildCategoryMarker(point),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 24,
            right: 24,
            child: GestureDetector(
              onTap: () => context.push('/buscar-ruta'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 12),
                    Text(
                      'Buscar ruta o destino...',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (isLoadingLocation)
            const Positioned(
              top: 120,
              right: 24,
              child: Chip(
                avatar: SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                label: Text('Obteniendo ubicación...'),
              ),
            ),
          DraggableScrollableSheet(
            initialChildSize: 0.28,
            minChildSize: 0.15,
            maxChildSize: 0.65,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (selectedRoute != null) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(Icons.navigation, color: Colors.white, size: 20),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Siguiendo ruta activa:',
                                      style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      selectedRoute!.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: theme.textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.push('/detalles-ruta', extra: selectedRoute),
                                child: const Text('Ver'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rutas Sugeridas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => context.push('/buscar-ruta'),
                            child: Text(
                              'Ver todo',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 90,
                        child: mapaAsync.when(
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (_, __) => const SizedBox(),
                          data: (state) => ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.suggestedRoutes.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final route = state.suggestedRoutes[index];
                              final isSelected = selectedRoute?.id == route.id;
                              return _SuggestedRouteCard(
                                route: route,
                                isSelected: isSelected,
                                onTap: () {
                                  setState(() {
                                    selectedRoute = route;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0), // Safely above draggable sheet
        child: FloatingActionButton(
          onPressed: () {
            if (userLocation != null) {
              mapController.move(userLocation!, 15.0);
            }
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}

class _SuggestedRouteCard extends StatelessWidget {
  final RouteEntity route;
  final bool isSelected;
  final VoidCallback onTap;

  const _SuggestedRouteCard({
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : (isDark ? Colors.grey.shade800 : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              route.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${route.duration} • ${route.distance}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: 0.7,
                backgroundColor: theme.dividerColor.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
