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

import '../../features/home/presentation/views/detalles_view.dart';
import '../../features/home/presentation/views/explora_feed_view.dart';
import '../../features/home/presentation/views/explora_view.dart';
import '../../features/home/presentation/views/reseñas_view.dart';
import '../../features/home/presentation/views/swipe_screen.dart';

import '../../features/pasaporte/presentation/views/passport_view.dart';

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

    redirect: (
        BuildContext context,
        GoRouterState state,
        ) {
      final authState = ref.read(authViewModelProvider);

      // Mientras Riverpod todavía resuelve la sesión,
      // no forzamos una redirección prematura.
      if (authState.isLoading) {
        return null;
      }

      final isAuthenticated =
          authState.asData?.value != null;

      final currentPath = state.matchedLocation;

      // Splash controla su propia transición.
      if (currentPath == '/splash') {
        return null;
      }

      const publicRoutes = <String>{
        '/onboarding',
        '/gatekeeper',
        '/login',
        '/register',
        '/forgot-password',
        '/verify-otp',
        '/reset-password',
      };

      // Estas rutas son solo para visitantes.
      // OJO: reset-password NO está aquí porque después de verificar
      // el OTP Supabase puede crear una sesión válida y necesitamos
      // permitir que el usuario llegue a ResetPasswordView.
      const guestOnlyRoutes = <String>{
        '/onboarding',
        '/gatekeeper',
        '/login',
        '/register',
        '/forgot-password',
      };

      final isPublicRoute =
      publicRoutes.contains(currentPath);

      if (!isAuthenticated && !isPublicRoute) {
        return '/gatekeeper';
      }

      if (isAuthenticated &&
          guestOnlyRoutes.contains(currentPath)) {
        return '/home';
      }

      return null;
    },

    errorBuilder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.route_outlined,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ruta no encontrada',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.uri.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Volver al inicio'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },

    routes: [
      // ============================================================
      // SPLASH / AUTH
      // ============================================================

      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),

      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),

      GoRoute(
        path: '/gatekeeper',
        name: 'gatekeeper',
        builder: (context, state) {
          return const GatekeeperView();
        },
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginView();
        },
      ),

      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          return const SignUpView();
        },
      ),

      GoRoute(
        path: '/forgot-password',
        name: 'forgot_password',
        builder: (context, state) {
          return const ForgotPasswordView();
        },
      ),

      GoRoute(
        path: '/verify-otp',
        name: 'verify_otp',
        builder: (context, state) {
          final email = state.extra;

          if (email is! String || email.isEmpty) {
            return const ForgotPasswordView();
          }

          return VerifyOtpView(
            email: email,
          );
        },
      ),

      GoRoute(
        path: '/reset-password',
        name: 'reset_password',
        builder: (context, state) {
          return const ResetPasswordView();
        },
      ),

      // ============================================================
      // PERFIL
      // Fuera del StatefulShellRoute para abrir sobre el shell.
      // ============================================================

      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          return const ProfileView();
        },
      ),

      GoRoute(
        path: '/edit-profile',
        name: 'edit_profile',
        builder: (context, state) {
          final profile = state.extra;

          if (profile is! Profile) {
            return const ProfileView();
          }

          return EditProfileView(
            profile: profile,
          );
        },
      ),

      // ============================================================
      // HOME / EXPLORACIÓN
      // Estas rutas existen porque ya son usadas en tu código actual.
      // ============================================================

      GoRoute(
        path: '/explora',
        name: 'explora',
        builder: (context, state) {
          return const ExploraScreen();
        },
      ),

      GoRoute(
        path: '/explora-feed',
        name: 'explora_feed',
        builder: (context, state) {
          return const ExploraFeedScreen();
        },
      ),

      GoRoute(
        path: '/detalles',
        name: 'detalles',
        builder: (context, state) {
          return const DetallesScreen();
        },
      ),

      GoRoute(
        path: '/resenas',
        name: 'resenas',
        builder: (context, state) {
          return const ResenasScreen();
        },
      ),

      // ============================================================
      // NAVEGACIÓN PRINCIPAL
      // ============================================================

      StatefulShellRoute.indexedStack(
        builder: (
            context,
            state,
            navigationShell,
            ) {
          return MainScaffold(
            navigationShell: navigationShell,
          );
        },

        branches: [
          // --------------------------------------------------------
          // 1. EXPLORAR
          // --------------------------------------------------------
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) {
                  return const SwipeScreen();
                },
              ),
            ],
          ),

          // --------------------------------------------------------
          // 2. MAPA
          // En lib.zip NO existe una vista real del mapa.
          // Solo existen mapa_providers.g.dart y mapa_viewmodel.g.dart.
          // Esta ruta resuelve correctamente y puede sustituirse
          // por la vista real cuando el equipo agregue el archivo.
          // --------------------------------------------------------
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mapa',
                name: 'mapa',
                builder: (context, state) {
                  return const _MapUnavailableView();
                },
              ),
            ],
          ),

          // --------------------------------------------------------
          // 3. PASAPORTE
          // --------------------------------------------------------
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pasaporte',
                name: 'pasaporte',
                builder: (context, state) {
                  return const PassportView();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _MapUnavailableView extends StatelessWidget {
  const _MapUnavailableView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.map_outlined,
              size: 56,
            ),
            SizedBox(height: 12),
            Text(
              'El módulo de mapa todavía no contiene una vista.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
