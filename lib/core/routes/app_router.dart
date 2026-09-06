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

import '../../features/pasaporte/presentation/views/passport_view.dart';

// IMPORTA AQUÍ LA PANTALLA REAL DEL MAPA.
// Ejemplo:
// import '../../features/mapa/presentation/views/map_view.dart';

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

    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 54,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ruta no encontrada',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.uri.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      );
    },

    redirect: (
        BuildContext context,
        GoRouterState state,
        ) {
      final authState = ref.read(
        authViewModelProvider,
      );

      final isAuthenticated =
          authState.asData?.value != null;

      final currentPath = state.matchedLocation;

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

      final isPublicRoute =
      publicRoutes.contains(currentPath);

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
          final email = state.extra as String?;

          if (email == null || email.isEmpty) {
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
          final extra = state.extra;

          if (extra is! Profile) {
            return const ProfileView();
          }

          return EditProfileView(
            profile: extra,
          );
        },
      ),


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


          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mapa',
                name: 'mapa',
                builder: (context, state) {
                  return const _MapRoutePlaceholder();
                },
              ),
            ],
          ),

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


class _MapRoutePlaceholder extends StatelessWidget {
  const _MapRoutePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.map_outlined,
          size: 64,
        ),
      ),
    );
  }
}