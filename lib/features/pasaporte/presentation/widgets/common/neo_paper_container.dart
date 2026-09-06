import 'package:flutter/material.dart';

class PassportPalette {
  static const parchment = Color(0xFFFBF8E3);
  static const paper = Color(0xFFFBF8E3);
  static const ink = Color(0xFF004046);
  static const leather = Color(0xFF8C5C58);
  static const leatherDark = Color(0xFF8C5C58);
  static const gold = Color(0xFFFEA94C);
  static const green = Color(0xFF84A98C);
  static const orange = Color(0xFFFEA94C);
  static const muted = Color(0xFF8C5C58);
  static const locked = Color(0xFF84A98C);
  static const reward = Color(0xFF8C5C58);
}

class NeoPaperContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const NeoPaperContainer({super.key, required this.child,
    this.padding = const EdgeInsets.all(16)});
  @override Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: PassportPalette.paper,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: PassportPalette.gold.withOpacity(.20)),
      boxShadow: const [
        BoxShadow(color: Color(0x16000000), blurRadius: 14, offset: Offset(0,6)),
      ],
    ),
    child: child,
  );
}
