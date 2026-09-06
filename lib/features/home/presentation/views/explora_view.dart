import 'package:flutter/material.dart';
// Importa go_router si vas a habilitar la navegación
// import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Color principal del diseño (verde oscuro/azul marino)
    const primaryColor = Color(0xFF163323);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cabecera (Bienvenida y Perfil)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Buenas tardes,',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        'Explorador',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 26,
                    // Reemplazar con imagen real si tienes
                    backgroundColor: primaryColor,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Título de la App (Ohtli)
              const Text(
                'Ohtli',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              // 3. Sección: Circuitos Recomendados (Título y Ver todos)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Circuitos Recomendados',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                    label: const Text(
                      'Ver todos',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 4. Lista Horizontal de Circuitos Recomendados
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Mock data
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return const RecommendedCircuitCard();
                  },
                ),
              ),
              const SizedBox(height: 32),

              // 5. Sección: Tu siguiente aventura (Título y Ver todos)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tu siguiente aventura',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                    label: const Text(
                      'Ver todos',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 6. Lista Vertical de Aventuras
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(), // Evita conflicto de scroll
                shrinkWrap: true,
                itemCount: 2, // Mock data
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return const NextAdventureCard();
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // 7. Barra de Navegación Inferior (BottomNavigationBar)
      /* BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Índice activo por defecto
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Buzón',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Más',
          ),
        ],
      ),*/
    );
  }
}

// 🃏 Widget: Tarjeta de Circuito Recomendado (Lista Horizontal)
class RecommendedCircuitCard extends StatelessWidget {
  const RecommendedCircuitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del circuito
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              'https://placehold.co/170x100.png', // Placeholder image
              height: 100,
              width: 170,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ubicación (Matagalpa)
                const Text(
                  'Matagalpa',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                // Título (Finca la esperanza)
                const Text(
                  'Finca la esperanza',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                // Calificación (Rating)
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Precio (Alineado a la derecha)
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '\$25 / persona',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🃏 Widget: Tarjeta de Siguiente Aventura (Lista Vertical)
class NextAdventureCard extends StatelessWidget {
  const NextAdventureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Imagen de la aventura
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              'https://placehold.co/100x120.png', // Placeholder image
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Detalles de la aventura
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Etiqueta (Gastronomía)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EAE1), // Color de fondo beige/crema
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Gastronomía',
                      style: TextStyle(color: Color(0xFF163323), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Título (Ruta del café)
                  const Text(
                    'Ruta del café',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  // Ubicación (Matagalpa) con ícono
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined, color: Colors.grey, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Matagalpa, Nicaragua',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Calificación (Rating) e ícono de Bookmark
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Spacer(), // Empuja el icono al final
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.bookmark_outline, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}