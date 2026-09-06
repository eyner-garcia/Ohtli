import 'package:latlong2/latlong.dart';

class RouteStepEntity {
  final int stepNumber;
  final String instruction;
  final String subInstruction;

  RouteStepEntity({
    required this.stepNumber,
    required this.instruction,
    required this.subInstruction,
  });
}

class RouteEntity {
  final String id;
  final String title;
  final String origin;
  final String destination;
  final String duration;
  final String distance;
  final String difficulty;
  final List<RouteStepEntity> steps;
  final List<LatLng> polylinePoints;

  RouteEntity({
    required this.id,
    required this.title,
    required this.origin,
    required this.destination,
    required this.duration,
    required this.distance,
    required this.difficulty,
    required this.steps,
    this.polylinePoints = const [],
  });
}
