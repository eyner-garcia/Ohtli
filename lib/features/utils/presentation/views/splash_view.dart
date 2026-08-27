import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    // 1. Inicia la animación de entrada (Fade in + Zoom) 100ms después de abrir la app
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _scale = 1.0;
        });
      }
    });

    // 2. Espera 3 segundos y navega automáticamente a la siguiente pantalla
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding'); // Redirige al Onboarding
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo verde oscuro elegante basado en tu diseño
      backgroundColor: const Color(0xFF163323),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2), // Duración del fundido
          curve: Curves.easeInOut,
          opacity: _opacity,
          child: AnimatedScale(
            duration: const Duration(seconds: 2), // Duración del zoom
            curve: Curves.easeOutCubic,
            scale: _scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícono / Logo provisional
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.travel_explore_rounded, // Ícono de viaje/mapa
                    size: 80,
                    color: Colors.lightGreenAccent,
                  ),
                ),
                const SizedBox(height: 24),

                // Título principal
                const Text(
                  'Ohtli',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtítulo
                const Text(
                  'Vive experiencias reales.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}