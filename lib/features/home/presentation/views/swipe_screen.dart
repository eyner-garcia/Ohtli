import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final CardSwiperController controller = CardSwiperController();

  // Lista de preferencias para el selector
  final List<Map<String, String>> preferencias = [
    {
      'titulo': 'Turismo Comunitario',
      'categoria': 'Cultura & Tradición',
      'descripcion': 'Visita talleres artesanales y conoce a emprendedores locales de Matagalpa.',
      'icono': '🏡',
    },
    {
      'titulo': 'Rutas de Café y Naturaleza',
      'categoria': 'Ecoturismo',
      'descripcion': 'Recorre fincas cafetaleras y senderos naturales en las montañas.',
      'icono': '☕',
    },
    {
      'titulo': 'Gastronomía Tradicional',
      'categoria': 'Sabores Locales',
      'descripcion': 'Prueba platillos típicos preparados por comedores comunitarios.',
      'icono': '🍲',
    },
    {
      'titulo': 'Arte y Cerámica',
      'categoria': 'Patrimonio Cultural',
      'descripcion': 'Aprende sobre la elaboración de artesanías y cerámica tradicional.',
      'icono': '🎨',
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Configura tu Vibra 🌟',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Subtítulo instructivo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Desliza a la derecha para Aceptar o a la izquierda para Rechazar tus gustos de viaje.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),

            // 🃏 Selector de Tarjetas estilo Tinder
            Expanded(
              child: CardSwiper(
                controller: controller,
                cardsCount: preferencias.length,
                onSwipe: (previousIndex, currentIndex, direction) {
                  return true; // Acepta el gesto de deslizamiento
                },
                onEnd: () {
                  // Al agotar las tarjetas, navega al Home principal
                  context.go('/home');
                },
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                cardBuilder: (context, index, percentX, percentY) {
                  final item = preferencias[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Círculo con Ícono / Ilustración
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            item['icono']!,
                            style: const TextStyle(fontSize: 55),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Etiqueta de Categoría
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['categoria']!,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Título
                        Text(
                          item['titulo']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Descripción
                        Text(
                          item['descripcion']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔘 Botones Inferiores de Acción (Rechazar / Aceptar)
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón Rechazar (X)
                  InkWell(
                    onTap: () => controller.swipe(CardSwiperDirection.left),
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.red.shade300, width: 2),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: const Icon(Icons.close, color: Colors.red, size: 32),
                    ),
                  ),

                  // Botón Aceptar (✓)
                  InkWell(
                    onTap: () => controller.swipe(CardSwiperDirection.right),
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 32),
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