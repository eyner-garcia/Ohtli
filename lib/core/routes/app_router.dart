import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/home/presentation/views/swipe_screen.dart';
import '../../features/home/presentation/views/explora_view.dart';
import '../../features/home/presentation/views/explora_feed_view.dart';
import '../../features/home/presentation/views/detalles_view.dart';
import '../../features/home/presentation/views/reseñas_view.dart';
import '../../features/utils/presentation/views/splash_view.dart';
import '../../features/utils/presentation/views/onboarding_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateStreamProvider);

  return GoRouter(
    initialLocation: '/home',
    redirect: (BuildContext context, GoRouterState state) {
      final session = authState.asData?.value.session;

      final publicRoutes = ['/splash', '/onboarding', '/login', '/quiz', '/register'];
      final isPublicRoute = publicRoutes.contains(state.matchedLocation);

      final isLoggingIn = state.matchedLocation == '/login';

      if (session == null && !isLoggingIn) return '/login';
      if (session != null && isLoggingIn) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => const SwipeScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const ExploraScreen(),
      ),
      GoRoute(
        path: '/explora-feed',
        builder: (context, state) => const ExploraFeedScreen(),
      ),
      GoRoute(
        path: '/detalles',
        builder: (context, state) => const DetallesScreen(),
      ),
      GoRoute(
        path: '/resenas',
        builder: (context, state) => const ResenasScreen(),
      ),
    ],
  );
});