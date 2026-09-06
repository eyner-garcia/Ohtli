import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../viewmodels/passport_viewmodel.dart';
import '../common/neo_paper_container.dart';

class DepartmentMapCard extends StatefulWidget {
  final List<PassportDepartmentState> departments;
  final ValueChanged<PassportDepartmentState>? onTap;

  const DepartmentMapCard({
    super.key,
    required this.departments,
    this.onTap,
  });

  @override
  State<DepartmentMapCard> createState() => _DepartmentMapCardState();
}

class _DepartmentMapCardState extends State<DepartmentMapCard> {
  static const _bucket = 'app';
  static const _objectPath =
      'mapa-nicaragua-bandera-mapa-bandera-nicaragua_516178-133.avif';

  late Future<String> _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = _createMapUrl();
  }

  Future<String> _createMapUrl() {
    return Supabase.instance.client.storage
        .from(_bucket)
        .createSignedUrl(
          _objectPath,
          60 * 60,
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<void> _retryImage() async {
    setState(() {
      _imageUrl = _createMapUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NeoPaperContainer(
      child: Column(
        children: [
          const Text(
            'MI PASAPORTE POR NICARAGUA',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900,
              color: PassportPalette.muted,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Toca una cabecera para explorar su progreso',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: PassportPalette.muted,
            ),
          ),
          const SizedBox(height: 10),

          AspectRatio(
            aspectRatio: .82,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned.fill(
                        child: FutureBuilder<String>(
                          future: _imageUrl,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return _MapError(
                                onRetry: _retryImage,
                                message:
                                    'No pudimos acceder a la imagen del mapa.',
                              );
                            }

                            if (snapshot.connectionState !=
                                    ConnectionState.done ||
                                snapshot.data == null) {
                              return const _MapLoading();
                            }

                            return Image.network(
                              snapshot.data!,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.medium,
                              errorBuilder: (_, __, ___) {
                                return _MapError(
                                  onRetry: _retryImage,
                                  message:
                                      'La imagen no pudo cargarse. '
                                      'Si está en AVIF, prueba WebP o PNG.',
                                );
                              },
                            );
                          },
                        ),
                      ),

                      Positioned.fill(
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: PassportPalette.paper.withOpacity(.08),
                            ),
                          ),
                        ),
                      ),

                      ...widget.departments.map(
                        (department) => _buildMarker(
                          constraints,
                          department,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 9),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 5,
            children: [
              _Legend(
                PassportPalette.locked,
                'Por descubrir',
              ),
              _Legend(
                PassportPalette.orange,
                'En progreso',
              ),
              _Legend(
                PassportPalette.green,
                'Descubierto',
              ),
              _Legend(
                PassportPalette.gold,
                'Completado',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(
    BoxConstraints constraints,
    PassportDepartmentState department,
  ) {
    final marker = _positionFor(department.nombre);

    if (marker == null) {
      return const SizedBox.shrink();
    }

    const markerWidth = 44.0;
    const markerHeight = 44.0;

    final left =
        (constraints.maxWidth * marker.x - markerWidth / 2)
            .clamp(0.0, constraints.maxWidth - markerWidth);

    final top =
        (constraints.maxHeight * marker.y - markerHeight / 2)
            .clamp(0.0, constraints.maxHeight - markerHeight);

    final color = _colorFor(department);

    return Positioned(
      left: left,
      top: top,
      width: markerWidth,
      height: markerHeight,
      child: Semantics(
        button: true,
        label:
            '${department.nombre}. ${department.porcentaje}% completado.',
        child: Tooltip(
          message:
              '${marker.capital} · ${department.nombre}\n'
              '${department.porcentaje}% completado',
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: widget.onTap == null
                ? null
                : () => widget.onTap!(department),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      color: PassportPalette.paper,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x44000000),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    department.completado
                        ? Icons.star_rounded
                        : department.porcentaje > 0
                            ? Icons.place_rounded
                            : Icons.lock_outline_rounded,
                    size: 15,
                    color: department.completado
                        ? PassportPalette.ink
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 1),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: PassportPalette.paper.withOpacity(.88),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    marker.capital,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 6.5,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: PassportPalette.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _colorFor(PassportDepartmentState department) {
    if (department.completado) {
      return PassportPalette.gold;
    }

    if (department.porcentaje == 0) {
      return PassportPalette.locked;
    }

    if (department.porcentaje >= 50) {
      return PassportPalette.green;
    }

    return PassportPalette.orange;
  }

  _MapMarker? _positionFor(String departmentName) {
    final normalized = _normalize(departmentName);

    for (final marker in _markers) {
      if (marker.aliases.any(
        (alias) => normalized.contains(_normalize(alias)),
      )) {
        return marker;
      }
    }

    return null;
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ñ', 'n')
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .trim();
  }
}

class _MapLoading extends StatelessWidget {
  const _MapLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PassportPalette.parchment,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 26,
        height: 26,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _MapError extends StatelessWidget {
  final Future<void> Function() onRetry;
  final String message;

  const _MapError({
    required this.onRetry,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PassportPalette.parchment,
      padding: const EdgeInsets.all(18),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.map_outlined,
            size: 42,
            color: PassportPalette.leather,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: PassportPalette.ink,
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: onRetry,
            child: const Text('REINTENTAR'),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend(
    this.color,
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 8,
            color: PassportPalette.muted,
          ),
        ),
      ],
    );
  }
}

class _MapMarker {
  final List<String> aliases;
  final String capital;
  final double x;
  final double y;

  const _MapMarker({
    required this.aliases,
    required this.capital,
    required this.x,
    required this.y,
  });
}

/// Coordenadas normalizadas (0..1), no píxeles.
/// Así los puntos conservan su posición en diferentes tamaños de pantalla.
///
/// Las dos regiones autónomas se incluyen por compatibilidad si existen
/// en la tabla `departamentos`; si tu MVP usa solo los 15 departamentos,
/// simplemente nunca se renderizan.
const _markers = <_MapMarker>[
  _MapMarker(
    aliases: ['Nueva Segovia'],
    capital: 'Ocotal',
    x: .36,
    y: .13,
  ),
  _MapMarker(
    aliases: ['Madriz'],
    capital: 'Somoto',
    x: .29,
    y: .20,
  ),
  _MapMarker(
    aliases: ['Esteli'],
    capital: 'Estelí',
    x: .36,
    y: .27,
  ),
  _MapMarker(
    aliases: ['Jinotega'],
    capital: 'Jinotega',
    x: .50,
    y: .23,
  ),
  _MapMarker(
    aliases: ['Matagalpa'],
    capital: 'Matagalpa',
    x: .49,
    y: .33,
  ),
  _MapMarker(
    aliases: ['Chinandega'],
    capital: 'Chinandega',
    x: .18,
    y: .35,
  ),
  _MapMarker(
    aliases: ['Leon'],
    capital: 'León',
    x: .23,
    y: .44,
  ),
  _MapMarker(
    aliases: ['Managua'],
    capital: 'Managua',
    x: .38,
    y: .50,
  ),
  _MapMarker(
    aliases: ['Boaco'],
    capital: 'Boaco',
    x: .54,
    y: .48,
  ),
  _MapMarker(
    aliases: ['Masaya'],
    capital: 'Masaya',
    x: .43,
    y: .56,
  ),
  _MapMarker(
    aliases: ['Carazo'],
    capital: 'Jinotepe',
    x: .38,
    y: .61,
  ),
  _MapMarker(
    aliases: ['Granada'],
    capital: 'Granada',
    x: .49,
    y: .61,
  ),
  _MapMarker(
    aliases: ['Chontales'],
    capital: 'Juigalpa',
    x: .61,
    y: .60,
  ),
  _MapMarker(
    aliases: ['Rivas'],
    capital: 'Rivas',
    x: .43,
    y: .72,
  ),
  _MapMarker(
    aliases: ['Rio San Juan'],
    capital: 'San Carlos',
    x: .68,
    y: .78,
  ),
  _MapMarker(
    aliases: [
      'Region Autonoma de la Costa Caribe Norte',
      'RACCN',
      'RAAN',
      'Costa Caribe Norte',
    ],
    capital: 'Bilwi',
    x: .72,
    y: .29,
  ),
  _MapMarker(
    aliases: [
      'Region Autonoma de la Costa Caribe Sur',
      'RACCS',
      'RAAS',
      'Costa Caribe Sur',
    ],
    capital: 'Bluefields',
    x: .75,
    y: .56,
  ),
];
