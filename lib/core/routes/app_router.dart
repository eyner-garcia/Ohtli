import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/auth/presentation/views/verify_otp_view.dart';
import '../../features/home/presentation/views/swipe_screen.dart';
import '../../features/perfil/domain/entities/profile.dart';
import '../../features/perfil/presentation/views/edit_profile_view.dart';
import '../../features/perfil/presentation/views/profile_view.dart';
import '../../features/utils/presentation/views/gatekeeper_view.dart';
import '../../features/utils/presentation/views/onboarding_view.dart';
import '../../features/utils/presentation/views/splash_view.dart';
import '../widgets/main_scaffold.dart';

part 'app_router.g.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(
      authViewModelProvider,
          (_, __) => notifyListeners(),
    );
  }
}

@Riverpod(keepAlive: true)
RouterNotifier routerNotifier(Ref ref) {
  return RouterNotifier(ref);
}

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authViewModelProvider);
      final isAuthenticated = authState.asData?.value != null;

      final currentPath = state.matchedLocation;

      // Permitir la pantalla de Splash sin forzar redirección de auth
      if (currentPath == '/splash') return null;

      final publicRoutes = [
        '/onboarding',
        '/gatekeeper',
        '/login',
        '/register',
        '/forgot-password',
        '/verify-otp',
        '/reset-password',
      ];
      final isPublicRoute = publicRoutes.contains(currentPath);

      if (!isAuthenticated && !isPublicRoute) {
        return '/gatekeeper';
      }

      if (isAuthenticated && isPublicRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/gatekeeper',
        name: 'gatekeeper',
        builder: (context, state) => const GatekeeperView(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot_password',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: '/verify-otp',
        name: 'verify_otp',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return VerifyOtpView(email: email);
        },
      ),
      GoRoute(
        path: '/reset-password',
        name: 'reset_password',
        builder: (context, state) => const ResetPasswordView(),
      ),

      // Rutas fijas de Perfil (fuera del StatefulShellRoute para superponerse)
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit_profile',
        builder: (context, state) {
          final profile = state.extra as Profile;
          return EditProfileView(profile: profile);
        },
      ),

      // Shell para navegación inferior principal
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Rama 1: Explorar (Home / Swipe Screen)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Rama 2: Mapa
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mapa',
                name: 'mapa',
                builder: (context, state) =>
                const Center(child: Text('Pantalla de Mapa')),
              ),
            ],
          ),
          // Rama 3: Pasaporte
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pasaporte',
                name: 'pasaporte',
                builder: (context, state) =>
                const Center(child: Text('Pantalla de Pasaporte')),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ohtli - Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authViewModelProvider.notifier).logout(),
          ),
        ],
      ),
      body: const Center(child: Text('¡Bienvenido a tu próxima Aventura!')),
    );
  }
}