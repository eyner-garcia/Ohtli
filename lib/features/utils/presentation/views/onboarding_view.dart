import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Las 3 láminas basadas en tu diseño
  final List<Map<String, String>> _slides = [
    {
      'title': '¿Qué es Ohtli?',
      'description': 'Descubre destinos auténticos y experiencias únicas guiadas por la comunidad local.',
      'icon': '🗺️',
    },
    {
      'title': '¿Para qué sirve?',
      'description': 'Conecta con la cultura local, apoya a emprendedores comunitarios y gana recompensas por explorar.',
      'icon': '🌟',
    },
    {
      'title': '¿Cómo funciona?',
      'description': 'Configura tu vibra de viaje, explora circuitos recomendados y escanea códigos QR para ganar puntos.',
      'icon': '🚀',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Botón Omitir para ir directo al Login
          if (_currentPage < _slides.length - 1)
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text(
                'Omitir',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Contenido deslizable (PageView)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Círculo con Ícono / Ilustración
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFF163323).withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            slide['icon']!,
                            style: const TextStyle(fontSize: 60),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Título
                        Text(
                          slide['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163323),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Descripción
                        Text(
                          slide['description']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 2. Indicadores de puntos (Dots) y Botón Principal
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Puntos de navegación
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF163323)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Botón Dinámico (Siguiente / Empezar)
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < _slides.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Al finalizar las láminas navega a Login
                          context.go('/login');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF163323),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _slides.length - 1 ? 'Empezar' : 'Siguiente',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}