import 'package:flutter/material.dart';
import 'neo_paper_container.dart';

class StampActionFab extends StatelessWidget {
  final VoidCallback onPressed;

  const StampActionFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
    onPressed: onPressed,
    backgroundColor: PassportPalette.leatherDark,
    foregroundColor: PassportPalette.paper,
    icon: const Icon(Icons.qr_code_scanner_rounded),
    label: const Text(
      'Sellar visita',
      style: TextStyle(fontWeight: FontWeight.w800),
    ),
  );
}