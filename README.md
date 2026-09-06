# 🌿 Ohtli — Aplicación de Turismo Sostenible

<div align="center">

**Desarrollado por el equipo: [Sirius]**

[![Flutter](https://img.shields.io/badge/Flutter-3.11+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com)
[![Riverpod](https://img.shields.io/badge/Riverpod-State_Management-00A67E?style=for-the-badge)](https://riverpod.dev)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-PostGIS-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org)

</div>

---

## 🔗 Enlaces de Interés

- **Repositorio de GitHub:** (https://github.com/unknown101101k/Ohtli) 
- **Carpeta de Google Drive (Video Demo):**(https://drive.google.com/drive/folders/120IihKDJa-C0h2XBG6cZ2Jxcq4HRteGl?usp=drive_link)

---

## 🧭 Descripción de la App

**Ohtli** es una aplicación móvil innovadora enfocada en el **Turismo Sostenible y Comunitario**. Su objetivo principal es conectar a los viajeros con experiencias auténticas, rutas ecológicas y puntos de interés (POI) locales, promoviendo el desarrollo socioeconómico de las comunidades y la preservación ambiental. 

La plataforma incluye:
- **Autenticación Segura**: Inicio de sesión, registro, recuperación de contraseña mediante OTP y perfiles de usuario personalizables.
- **Sistema de Recomendación Inteligente**: Puntuación ponderada basada en preferencias, geolocalización (PostGIS), popularidad y suscripciones premium.
- **Exploración y Feed Dinámico**: Destinos populares y lugares cercanos ordenados por proximidad real en tiempo real.
- **Mapa Interactivo con Rutas**: Visualización de puntos de interés categorizados por iconos y colores, seguimiento de rutas GPS en tiempo real y guías paso a paso (*Turn-by-turn*).
- **Pasaporte Turístico**: Registro de visitas, insignias y sellos obtenidos en cada aventura.

---

## 🛠️ Stack Tecnológico

| Capa / Componente | Tecnología |
| :--- | :--- |
| **Framework UI** | Flutter (Dart) |
| **Gestión de Estado & DI** | Riverpod (`flutter_riverpod`, `riverpod_annotation` con Generación de Código) |
| **Enrutamiento** | GoRouter (con `StatefulShellRoute` para navegación por pestañas) |
| **Backend & Base de Datos** | Supabase (PostgreSQL + PostGIS, Auth, Storage) |
| **Persistencia Local** | Drift (SQLite relacional) |
| **Mapas & Ubicación** | `flutter_map` (OpenStreetMap), `latlong2`, `geolocator` |

---

## 🏛️ Arquitectura del Software

Ohtli implementa **Clean Architecture** estructurada por *Features* (funcionalidades). Cada módulo es independiente y desacoplado, facilitando el mantenimiento y la escalabilidad.

```text
lib/
├── core/
│   ├── database/     # Base de datos local (Drift)
│   ├── routes/       # Configuración de GoRouter y Guards
│   ├── themes/       # Temas claros/oscuros y proveedores de tema
│   └── widgets/      # MainScaffold, CustomBottomNavigationBar, CustomDrawer
└── features/
    ├── auth/         # Autenticación y gestión de usuarios
    ├── home/         # Exploración, Feed, Detalles, Reseñas y Swipe de intereses
    ├── mapa/         # Mapa interactivo, cálculo de rutas y navegación
    ├── pasaporte/    # Insignias, sellos y logros del viajero
    └── perfil/       # Perfil de usuario, estadísticas y edición
```

Dentro de cada `feature`, la organización sigue estrictamente las tres capas de Clean Architecture:
- **`data/`**: Contiene los *DataSources* (remoto con Supabase, local con Drift), *Models* (DTOs con serialización JSON) y las implementaciones de los repositorios.
- **`domain/`**: El núcleo de la app. Contiene las *Entities* (modelos de negocio puros), las interfaces de los *Repositories* y los **Use Cases** (casos de uso que encapsulan la lógica de negocio individual).
- **`presentation/`**: Contiene las *Views* (`ConsumerWidget`), *ViewModels* (Notifiers con `@riverpod`) y componentes visuales específicos.

---

## 🗄️ Entidades y Estructura de Base de Datos (Supabase / PostgreSQL)

La base de datos relacional en Supabase utiliza extensiones geoespaciales (**PostGIS**) y está compuesta por las siguientes tablas principales:

1. **`usuarios`**: Almacena información extendida del usuario vinculada a Supabase Auth (`auth_id`, `nombre_completo`, `correo`, `foto_perfil_url`).
2. **`puntos_interes` (POI)**: Lugares turísticos con geolocalización (`id`, `negocio_id`, `categoria_id`, `nombre`, `descripcion`, `direccion`, `latitud`, `longitud`, `ubicacion` [PostGIS], `foto_portada_url`, `promedio_calificacion`, `total_resenas`, `es_activo`).
3. **`categorias_poi`**: Clasificación de los puntos de interés (`id`, `nombre`, `descripcion`, `icono_url`).
4. **`favoritos`**: Relación de POI marcados como favoritos por los usuarios (`usuario_id`, `poi_id`).
5. **`pasaporte_sellos`**: Registro de visitas y sellos coleccionados en el pasaporte turístico.
6. **`usuarios_rutas`**: Historial y rutas guardadas por el usuario.
7. **`usuarios_insignias`**: Logros e insignias desbloqueadas.
8. **`suscripciones` & `negocios_locales`**: Gestión de comercios locales y su vigencia Premium para el algoritmo de recomendación.

### 🧠 Algoritmo de Recomendación
El sistema calcula un `ScoreTotal` (0% a 100%) para ordenar los puntos de interés mediante un modelo de scoring lineal ponderado:
$$\text{ScoreTotal} = 0.35(S_{\text{pref}}) + 0.35(S_{\text{geo}}) + 0.20(S_{\text{pop}}) + 0.10(S_{\text{prem}})$$
- **$S_{\text{pref}}$ (35%)**: Coincidencia con las preferencias turísticas del usuario.
- **$S_{\text{geo}}$ (35%)**: Proximidad geográfica calculada mediante PostGIS.
- **$S_{\text{pop}}$ (20%)**: Popularidad combinando reseñas ponderadas por confianza estadística y cantidad de favoritos ($\alpha = 0.7$, $\beta = 0.3$).
- **$S_{\text{prem}}$ (10%)**: Estado activo de suscripción del negocio local.

---

## 🚀 Instalación y Puesta en Marcha

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/unknown101101k/Ohtli.git
   cd Ohtli
   ```

2. **Configurar las variables de entorno**:
   Crea un archivo `.env` en la raíz del proyecto basándote en tu instancia de Supabase:
   ```env
   SUPABASE_URL=https://tu-proyecto.supabase.co
   SUPABASE_ANON_KEY=tu-anon-key-de-supabase
   ```

3. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

4. **Generar archivos con Riverpod Code Generation (`build_runner`)**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```

---

## 👥 Equipo de Desarrollo

Este proyecto ha sido desarrollado con dedicación por el equipo **Sirius**.
