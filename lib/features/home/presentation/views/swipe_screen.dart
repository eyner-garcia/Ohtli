import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final CardSwiperController controller = CardSwiperController();

  final List<Map<String, String>> categories = [
    {
      'titulo': 'Naturaleza',
      'descripcion': 'Parques, senderos, paisajes',
    },
    {
      'titulo': 'Gastronomía',
      'descripcion': 'Platillos típicos, sabores locales',
    },
    {
      'titulo': 'Cultura',
      'descripcion': 'Museos, historia, tradiciones',
    },
    {
      'titulo': 'Aventura',
      'descripcion': 'Deportes extremos, exploración',
    },
    {
      'titulo': 'Descanso',
      'descripcion': 'Playas, relajación, bienestar',
    },
  ];

  int currentIndex = 0;

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
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Text(
              '9:41',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  width: 20,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1C1E),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Elige tus Intereses',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1C1E),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Desliza para elegir',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CardSwiper(
              controller: controller,
              cardsCount: categories.length,
              numberOfCardsDisplayed: 2,
              backCardOffset: const Offset(20, 20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              onSwipe: (previousIndex, current, direction) {
                setState(() {
                  currentIndex = current ?? 0;
                });
                return true;
              },
              cardBuilder: (context, index, percentX, percentY) {
                final category = categories[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF1A1C1E), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // Espacio para la imagen
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category['titulo']!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1C1E),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['descripcion']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ActionButton(
                  icon: Icons.arrow_back,
                  label: 'No',
                  onTap: () => controller.swipe(CardSwiperDirection.left),
                ),
                _ActionButton(
                  icon: Icons.arrow_forward,
                  label: 'Si',
                  isRight: true,
                  onTap: () => controller.swipe(CardSwiperDirection.right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            '${currentIndex + 1} de ${categories.length}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1C1E),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              categories.length,
              (index) => Container(
                width: index == currentIndex ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == currentIndex
                      ? const Color(0xFF1A1C1E)
                      : const Color(0xFFE1E3E4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 140,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isRight;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isRight) Icon(icon, size: 24, color: const Color(0xFF1A1C1E)),
          if (!isRight) const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1C1E),
            ),
          ),
          if (isRight) const SizedBox(width: 8),
          if (isRight) Icon(icon, size: 24, color: const Color(0xFF1A1C1E)),
        ],
      ),
    );
  }
}
