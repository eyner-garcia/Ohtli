import 'package:flutter/material.dart';

class PassportPalette {
  static const parchment = Color(0xFFF4E9D2);
  static const paper = Color(0xFFFFF9EC);
  static const ink = Color(0xFF2C2118);
  static const leather = Color(0xFF70451F);
  static const leatherDark = Color(0xFF45260F);
  static const gold = Color(0xFFD1A23A);
  static const green = Color(0xFF657B3B);
  static const orange = Color(0xFFD98B25);
  static const muted = Color(0xFF776B5D);
  static const locked = Color(0xFFAAA49A);
  static const reward = Color(0xFF8A531D);
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
